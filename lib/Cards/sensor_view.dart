import 'package:flutter/material.dart';

import 'internalClass.dart';

class SensorViewPage extends StatelessWidget {
  SensorViewPage({super.key});

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
      body: sensorGridView2(context),
    );
  }

  Widget sensorGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(10, (index) {
        return sensorCard(context, "Sensor_$index", "Soil Moisture", 100);
      }),
    );
  }

  Widget sensorGridView2(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: sampleData.length,
        itemBuilder: ((context, index) {
          var item = sampleData[index];
          return sensorCard(context, item['sensorName'].toString(),
              item['sensorType'].toString(), item['sensorValue'] as int);
        }));
  }

  Widget sensorCard(BuildContext context, String sensorName, String sensorType,
      int sensorValue) {
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
