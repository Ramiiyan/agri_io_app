import 'dart:convert';

import 'package:agri_io_app/BaseComponents/AppWidgets.dart';
import 'package:agri_io_app/Models/sensor_model.dart';
import 'package:agri_io_app/Services/HttpService.dart';
import 'package:flutter/material.dart';

import '../routes/Routes.dart';
import 'internalClass.dart';

class SensorViewPage extends StatefulWidget {
  SensorViewPage({super.key});
  @override
  SensorViewPageState createState() => SensorViewPageState();
}

class SensorViewPageState extends State<SensorViewPage> {
  final HttpService httpService = HttpService();
  List<Sensor>? sensorList;
  final _editFormKey = GlobalKey<FormState>();
  late String _editSensorName, _editSensorType;
  final sampleData = [
    {
      "sensorId": "da0b44f86a73",
      "sensorName": "Sensor_01",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 88,
    },
    {
      "sensorId": "fc1d82c42fe0",
      "sensorName": "Sensor_02",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 77
    },
    {
      "sensorId": "cb8f54cb8f5d",
      "sensorName": "Sensor_03",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 47
    },
    {
      "sensorId": "da082cfc13",
      "sensorName": "Sensor_04",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-dafe44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 100
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri.IO'),
      ),
      body: RefreshIndicator(
          onRefresh: () => refreshSensors(context),
          child: sensorGridView2(context)),
      floatingActionButton: FloatingActionButton(
          heroTag: 'SensorTag',
          // backgroundColor: Color.fromARGB(0, 255, 255, 255),
          child: const Icon(
            Icons.add_circle,
            size: 55,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.addSensor);
          }),
    );
  }

  Future<void> refreshSensors(BuildContext context) async {
    final sensors = await httpService.fetchSensors();
    setState(() {
      sensorList = sensors;
    });
  }

  Widget sensorGridView2(BuildContext context) {
    return FutureBuilder(
        future: httpService.fetchSensors(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Sensor>? sensors = snapshot.data;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: sensors!.length,
                itemBuilder: ((context, index) {
                  return sensorCard(
                      context: context,
                      sensorId: sensors[index].getSensorId,
                      sensorName: sensors[index].getSensorName,
                      sensorType: sensors[index].getType,
                      sensorValue: sensors[index].getSensorValue!.toInt());
                }));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget sensorGridView(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: sampleData.length,
        itemBuilder: ((context, index) {
          var item = sampleData[index];
          return sensorCard(
              context: context,
              sensorId: item['sensorId'].toString(),
              sensorName: item['sensorName'].toString(),
              sensorType: item['sensorType'].toString(),
              sensorValue: item['sensorValue'] as int);
        }));
  }

  Widget sensorCard(
      {required BuildContext context,
      required String sensorId,
      required String sensorName,
      required String sensorType,
      int? sensorValue}) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sensorName,
                    style: MyTextSample.title(context)!
                        .copyWith(color: MyColorsSample.grey_80)),
                Container(
                  height: 10,
                ),
                Text(sensorType),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 30,
                      child: IconButton(
                          onPressed: () =>
                              _showEditDialog(sensorId, sensorName, sensorType),
                          icon: const Icon(
                            Icons.edit,
                          )),
                    ),
                    SizedBox(
                      width: 30,
                      child: IconButton(
                          onPressed: () =>
                              _showDeleteDialog(sensorId, sensorName),
                          icon: const Icon(
                            Icons.delete,
                          )),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        Container(
          height: 25,
        ),
        Text("$sensorValue %",
            style: MyTextSample.display2(context)!
                .copyWith(color: const Color.fromARGB(255, 0, 0, 0))),
      ],
    ));
  }

  Future<void> _showDeleteDialog(String sensorId, String sensorName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Caution!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this $sensorName Sensor?')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                _deleteSensor(sensorName, sensorId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(
      String sensorId, String sensorName, String sensorType) async {
    _editSensorName = sensorName;
    _editSensorType = sensorType;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modify Sensor'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                    key: _editFormKey,
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Sensor Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                initialValue: sensorName,
                                onChanged: (value) {
                                  setState(() {
                                    _editSensorName = value.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  // if (_editSensorName.isEmpty) {
                                  //   _editSensorName = sensorName;
                                  // }
                                  // if (_editSensorType.isEmpty) {
                                  //   _editSensorType = sensorType;
                                  // }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Sensor Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                initialValue: sensorType,
                                onChanged: (value) {
                                  setState(() {
                                    _editSensorType = value.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true)),
                          ],
                        ),
                      ),
                    ])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Modify'),
              onPressed: () async {
                _editSensor(sensorId, _editSensorName, _editSensorType);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSensor(String sensorName, String sensorId) async {
    //print("Sensor Id for deletion: $sensorId");

    final res = await httpService.deleteSensor(sensorId);

    final Map<String, dynamic> jsonResponse = jsonDecode(res);

    if (jsonResponse['statusCode'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(AppWidgets(context)
          .notifySnackBar("Deleted Successfully.", color: Colors.red));
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.sensorView, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(AppWidgets(context)
          .notifySnackBar("Failed to Delete. Try again.",
              due: 10, color: Colors.red));
    }
  }

  void _editSensor(
      String sensorId, String sensorName, String sensorType) async {
    if (_editFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(AppWidgets(context)
          .notifySnackBar("Data Processing..", color: Colors.black));

      final res = await httpService
          .editSensor(Sensor.nonSensorValue(sensorId, sensorName, sensorType));

      final Map<String, dynamic> jsonResponse = jsonDecode(res);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (jsonResponse['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            AppWidgets(context).notifySnackBar("Modified Successfully."));
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.sensorView, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(AppWidgets(context)
            .notifySnackBar("Failed to create. Try again.",
                due: 10, color: Colors.red));
      }
    }
  }
}
