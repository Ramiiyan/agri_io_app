import 'package:agri_io_app/add_sensor.dart';
import 'package:flutter/material.dart';

import 'Cards/cardSample2.dart';
import 'Cards/MySampleCard.dart';
import 'Cards/internalClass.dart';

void main() => runApp(const MaterialApp(title: "Hello", home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri_IO'),
      ),
      body: const MySampleCard(),
      floatingActionButton: FloatingActionButton(
          heroTag: 'SensorTag',
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          child: Image.asset(ImgSample.get("add_sensor.png")),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSensor(),
                ));
          }),
      //backgroundColor: Colors.black,
    );
  }

  // Widget myCard = Container(
  //   padding: const EdgeInsets.all(32),
  //   child: Row,
  // );
}

class CardSample extends StatelessWidget {
  const CardSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Moisture Level"),
          ],
        ),
        Text(
          "Moisture Level",
          textAlign: TextAlign.right,
        ),
        ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.')),
      ],
    ));
    // ignore: dead_code
    throw UnimplementedError();
  }
}
