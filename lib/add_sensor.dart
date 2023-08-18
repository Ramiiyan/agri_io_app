import 'package:flutter/material.dart';

class AddSensor extends StatelessWidget {
  const AddSensor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("TODO: Add Sensor Form"),
      floatingActionButton: FloatingActionButton.extended(
          label: Row(children: [Icon(Icons.save), Text('Save')]),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSensor(),
                ));
          }),
    );
  }
}
