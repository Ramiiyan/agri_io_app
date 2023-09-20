import 'package:agri_io_app/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartsocketapp/WifiSetupInfo.dart';
import 'package:smartsocketapp/resetPassword.dart';
import 'package:smartsocketapp/routes/Routes.dart';
import 'package:smartsocketapp/welcome.dart';

import 'WifiSetup.dart';
import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'SmartSocket',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: Routes.customRoutes);
  }
}
