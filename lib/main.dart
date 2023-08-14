import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Cards/cardSample2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agri_IO'),
        ),
        body: const CardSample2(),
        //backgroundColor: Colors.black,
      ),
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
