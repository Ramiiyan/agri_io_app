import 'package:flutter/material.dart';

class AddSensor extends StatelessWidget {
  const AddSensor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri.IO'),
      ),
      body: Text("TODO: Add Sensor Form"),
      floatingActionButton: FloatingActionButton.extended(
          label: Row(children: [Icon(Icons.create), Text('Create')]),
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
