import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';
import 'bezierContainer.dart';

import 'package:smartsocketapp/baseComponents/appWidgets.dart';

class WifiSetupPage extends StatefulWidget {
  WifiSetupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WifiSetupStatePage createState() => _WifiSetupStatePage();
}

class _WifiSetupStatePage extends State<WifiSetupPage> {
  final String wifiInfoText =
      "For a seamless experience store your WiFi credentials on the App. Your credentials will only be stored on your device and not on any servers You can change your credentials anytime from your profile.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BaseAppBar is own class implements appBar
      appBar: BaseAppBar(
        leading: AppWidgets(context).appBarbackButton(() {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/wifiSetupInfo', (route) => false);
        }),
        titleSpan1: 'Smart',
        titleSpan2: 'Socket',
        appBar: AppBar(), //using same preference of appBar
      ),

      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.josefinSans(
                          textStyle: Theme.of(context).textTheme.headline1,
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Enter Your Wifi Credentials',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      _ssidPasswordWidgets(),
                      SizedBox(height: 30),
                      _button('Save', Colors.black, () {
                        print(' Wifi credentials Saved !');
                        Navigator.of(context).pushNamed('/home');
                      }, gradientColors: [Color(0xfffbb448), Color(0xfff7892b)])
                    ]),
              ),
              Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer())
            ],
          )),
    );
  }

  Widget _ssidPasswordWidgets() {
    return Column(
      children: <Widget>[
        AppWidgets(context).entryField('SSID'),
        AppWidgets(context).entryField('Password'),
      ],
    );
  }

  Widget _button(
      String buttonLabel, Color labelColor, void Function() onTapFunction,
      {List<Color> gradientColors}) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: gradientColors,
          )),
      child: InkWell(
        onTap: onTapFunction,
        splashColor: Colors.white38,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.4,
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            buttonLabel,
            style: TextStyle(
              fontSize: 16,
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
