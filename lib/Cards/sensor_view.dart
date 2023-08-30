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
  final sampleData = [
    {
      "sensorName": "Sensor_01",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 88
    },
    {
      "sensorName": "Sensor_02",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 77
    },
    {
      "sensorName": "Sensor_03",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "sensorType": "Soil Moisture",
      "sensorValue": 47
    },
    {
      "sensorName": "Sensor_04",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
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
                      sensorName: sensors[index].sensorName,
                      sensorType: sensors[index].type,
                      sensorValue: 100); //Random Value Assigned.
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
              sensorName: item['sensorName'].toString(),
              sensorType: item['sensorType'].toString(),
              sensorValue: item['sensorValue'] as int);
        }));
  }

  Widget sensorCard(
      {required BuildContext context,
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
        Text(sensorName,
            style: MyTextSample.title(context)!
                .copyWith(color: MyColorsSample.grey_80)),
        Container(
          height: 10,
        ),
        Text(sensorType),
        Container(
          height: 30,
        ),
        Text("$sensorValue %",
            style: MyTextSample.display2(context)!
                .copyWith(color: const Color.fromARGB(255, 0, 0, 0))),
      ],
    ));
  }
}
