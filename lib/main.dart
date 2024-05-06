import 'package:agri_io_app/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Cards/internalClass.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri.IO',
      theme: agrioAppTheme(context, false),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
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
}

ThemeData agrioAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    useMaterial3: false,
    // colorSchemeSeed: Colors.green,
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
    textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
      bodyLarge: GoogleFonts.montserrat(
          textStyle: Theme.of(context).textTheme.bodyLarge),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.all(isDarkTheme ? Colors.orange : Colors.green),
    ),
    listTileTheme: ListTileThemeData(
        iconColor: isDarkTheme ? Colors.orange : Colors.green),
    appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.raleway(
            textStyle: MyTextSample.title(context)!
                .copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkTheme ? Colors.green : Colors.black54)),
  );
}
