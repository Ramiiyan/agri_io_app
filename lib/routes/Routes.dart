import 'package:agri_io_app/sensor_view.dart';
import 'package:agri_io_app/login_page.dart';
import 'package:agri_io_app/add_sensor.dart';
import 'package:flutter/cupertino.dart';
// import 'package:smartsocketapp/AddDevice.dart';
// import 'package:smartsocketapp/ShareDevice.dart';
// import 'package:smartsocketapp/welcome.dart';

// import '../SharePermission.dart';
// import '../WifiSetup.dart';
// import '../WifiSetupInfo.dart';
// import '../home.dart';
// import '../login.dart';
// import '../resetPassword.dart';
// import '../signup.dart';

class Routes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetPwd = '/resetPwd';
  static const String wifiSetupInfo = '/wifiSetupInfo';
  static const String wifiSetup = '/wifiSetup';
  static const String home = '/home';
  static const String deviceView = '/devices';
  static const String sensorView = '/sensors';
  static const String addDevice = '/addDevice';
  static const String addSensor = '/addSensor';
  static const String shareDevice = '/shareDevice';
  static const String sharePermission = '/sharePermission';

  static var customRoutes = <String, WidgetBuilder>{
    //welcome:(BuildContext context) => WelcomePage(),
    login: (context) => LoginPage(),
    // signup : (BuildContext context) => SignUpPage(),
    // resetPwd : (BuildContext context) => ResetPasswordPage(),
    // wifiSetupInfo : (BuildContext context) => WifiSetupInfoPage(),
    // wifiSetup : (BuildContext context) => WifiSetupPage(),
    // home : (BuildContext context) => HomePage(),
    sensorView: (context) => SensorViewPage(),
    // addDevice : (BuildContext context) => AddDevicePage(),
    addSensor: (context) => AddSensor(),
    // shareDevice : (BuildContext context) => ShareDevicePage(),
    // sharePermission : (BuildContext context) => SharePermissionPage(),
  };
}
