import 'dart:convert';
import 'dart:developer';

import 'package:agri_io_app/Models/socketDto_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:agri_io_app/BaseComponents/AppWidgets.dart';
import 'package:agri_io_app/Models/sensor_model.dart';
import 'package:agri_io_app/Services/HttpService.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'Services/StreamStocket.dart';
import 'routes/Routes.dart';
import 'Cards/internalClass.dart';
import 'my_global.dart' as global;

class SensorViewPage extends StatefulWidget {
  const SensorViewPage({super.key});
  @override
  SensorViewPageState createState() => SensorViewPageState();
}

class SensorViewPageState extends State<SensorViewPage> {
  late final String myHostname = global.hostname;
  final HttpService httpService = HttpService();
  late IO.Socket socket;
  StreamSocket streamSocket = StreamSocket();

  List<Sensor>? _sensorList, _socketSensorList;
  final _editFormKey = GlobalKey<FormState>();
  late String _editSensorName, _editSensorType, _addSensorId;
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
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await refreshSensors();
      setState(() {});
    });
    initSocket();
    dataListener();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  initSocket() {
    socket = IO.io(
        'http://$myHostname:9092/?room=a',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    // socket.on('user112', (data) => streamSocket.addResponse);
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  dataListener() {
    socket.on('user112', (data) {
      //print("Received Socket Data: ${data["message"]}");
      SocketDto socketDto = SocketDto.fromJson(data as Map<String, dynamic>);
      setState(() {
        _socketSensorList = socketDto.getSocketSensorList;
        // _sensorList![0].setSensorValue =
        //     socketDto.getSocketMessage[0].getSensorValue!;
      });
      if (_socketSensorList != null && _sensorList != null) {
        // print("=====================START===============================");
        List<dynamic>? dbSensorIds =
            _sensorList?.map((dbSensor) => dbSensor.getSensorId).toList();

// Extract the sensor IDs from mqttList
        List<dynamic>? mqttSensorIds = _socketSensorList
            ?.map((socketSensor) => socketSensor.getSensorId)
            .toList();

// Find the sensor IDs that exist in mqttList but not in dbList
        List<dynamic>? nonExistentSensorIds = mqttSensorIds
            ?.where((sensorId) => !dbSensorIds!.contains(sensorId))
            .toList();

        List<Sensor>? nonExistentSensors = _socketSensorList
            ?.where((socketSensor) =>
                nonExistentSensorIds!.contains(socketSensor.getSensorId))
            .toList();
        if (nonExistentSensorIds!.isNotEmpty) {
          // print(
          //     "Sensor IDs in mqttList but not in dbList: $nonExistentSensorIds");
          // print("Maps for non-existent sensors: $nonExistentSensors");
          nonExistentSensors?.forEach((detectedSensor) {
            _showEditOrAddDialog(detectedSensor.getSensorId,
                detectedSensor.getSensorName, detectedSensor.getType,
                addAsNewSensor: true);
            //_showNewSensorDialog();
          });
          refreshSensors();
        } else {
          print("No new Sensors Found!");
        }

        // print("=====================END===============================");
      }
      // print(
      //     "Received Sensor Valueeeeeee: ${_socketSensorList![0].getSensorValue}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AGRI.IO'),
      ),
      body: RefreshIndicator(
          onRefresh: () => refreshSensors(), child: sensorGridView2(context)),
      floatingActionButton: FloatingActionButton(
          heroTag: 'SensorTag',
          // backgroundColor: Color.fromARGB(0, 255, 255, 255),
          child: const Icon(
            Icons.add_circle,
            size: 55,
          ),
          onPressed: () {
            // dataListener();
            Navigator.of(context).pushNamed(Routes.addSensor);
          }),
    );
  }

  Future<void> refreshSensors() async {
    final sensors = await httpService.fetchSensors();
    setState(() {
      _sensorList = sensors;
      //_socketSensorList = sensors;
    });
  }

  int? getMqttSensorData(String sensorId) {
    log("this sensorId:$sensorId");
    if (_socketSensorList != null) {
      Sensor? relevantSensor = _socketSensorList!
          .where((element) => element.getSensorId == sensorId)
          .firstOrNull;

      log("getMqttSensorData: ${relevantSensor?.getSensorValue}");
      return relevantSensor?.getSensorValue?.round() ?? 0;
    } else {
      return 1;
    }
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
                      sensorValue:
                          getMqttSensorData(sensors[index].getSensorId));
                }));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget sensorGridViewTest(BuildContext context) {
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

  Widget streamSensorGridView(BuildContext context) {
    return StreamBuilder(
        stream: streamSocket.getResponse,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (_sensorList != null) {
            List<Sensor>? sensors = _sensorList;
            print("StreamSensor :${snapshot.data}");
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
                      sensorValue: sensors[index].getSensorValue as int);
                }));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
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
                          onPressed: () => _showEditOrAddDialog(
                              sensorId, sensorName, sensorType),
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

  Widget _buildStreamBuilder(Stream<String>? stream) {
    return Center(
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Text("${snapshot.data}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
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

  Future<void> _showNewSensorDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Caution!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('New Sensor Found!')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditOrAddDialog(
      String sensorId, String sensorName, String sensorType,
      {bool addAsNewSensor = false}) async {
    _addSensorId = sensorId;
    _editSensorName = sensorName;
    _editSensorType = sensorType;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(addAsNewSensor ? 'New Sensor Found!' : 'Modify Sensor'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                    key: _editFormKey,
                    child: Column(children: <Widget>[
                      // Sensor ID only for Adding scenario
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: addAsNewSensor
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      "Sensor ID",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        initialValue: sensorId,
                                        onChanged: (value) {
                                          setState(() {
                                            _addSensorId = value.toString();
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
                                )
                              : null),
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
              child: Text(addAsNewSensor ? 'Add' : 'Modify'),
              onPressed: () async {
                _editOrAddSensor(sensorId, _editSensorName, _editSensorType,
                    addAsNewSensor: addAsNewSensor);
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

  void _editOrAddSensor(String sensorId, String sensorName, String sensorType,
      {bool addAsNewSensor = false}) async {
    if (_editFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(AppWidgets(context)
          .notifySnackBar("Data Processing..", color: Colors.black));
      final res;
      if (addAsNewSensor) {
        print("Added the Sensor as New Sensor to DB...");
        res = await httpService.createSensorWithId(
            Sensor.nonSensorValue(sensorId, sensorName, sensorType));
      } else {
        res = await httpService.editSensor(
            Sensor.nonSensorValue(sensorId, sensorName, sensorType));
      }
      final Map<String, dynamic> jsonResponse = jsonDecode(res);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (jsonResponse['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            AppWidgets(context).notifySnackBar("Modified Successfully."));
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.sensorView, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(AppWidgets(context)
            .notifySnackBar("Failed to Modify. Try again.",
                due: 10, color: Colors.red));
      }
    }
  }
}
