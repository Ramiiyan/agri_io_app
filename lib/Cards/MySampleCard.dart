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
