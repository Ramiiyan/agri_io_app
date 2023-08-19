import 'package:agri_io_app/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Agri.IO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyLarge: GoogleFonts.montserrat(textStyle: textTheme.bodyLarge),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/sensors',
      routes: Routes.customRoutes,
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Agri.IO'),
    //   ),
    //   body: const MySampleCard(),

    //   floatingActionButton: FloatingActionButton(
    //       heroTag: 'SensorTag',
    //       // backgroundColor: Color.fromARGB(0, 255, 255, 255),
    //       child: const Icon(
    //         Icons.add_circle,
    //         size: 55,
    //       ),
    //       onPressed: () {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => const AddSensor(),
    //             ));
    //       }),
    //   //backgroundColor: Colors.black,
    // );
  }

  // Widget myCard = Container(
  //   padding: const EdgeInsets.all(32),
  //   child: Row,
  // );
}

// class CardSample extends StatelessWidget {
//   const CardSample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Card(
//         child: Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text("Moisture Level"),
//           ],
//         ),
//         Text(
//           "Moisture Level",
//           textAlign: TextAlign.right,
//         ),
//         ListTile(
//             leading: Icon(Icons.album),
//             title: Text('The Enchanted Nightingale'),
//             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.')),
//       ],
//     ));
//     // ignore: dead_code
//     throw UnimplementedError();
//   }
// }
