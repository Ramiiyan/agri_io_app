import 'package:flutter/material.dart';

import 'internalClass.dart';

class MySampleCard extends StatelessWidget {
  const MySampleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(10, (index) {
        return myCard(context, "Sensor_$index", "Soil Moisture", 100);
      }),
    );
  }

  Widget myCard(BuildContext context, String sensorName, String sensorType,
      int sensorValue) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(sensorName,
            style: MyTextSample.title(context)!
                .copyWith(color: MyColorsSample.grey_80)),
        Text(sensorType),
        Text("$sensorValue %",
            style: MyTextSample.display1(context)!
                .copyWith(color: const Color.fromARGB(255, 0, 0, 0))),
      ],
    ));
  }
}
