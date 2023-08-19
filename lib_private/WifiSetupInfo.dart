import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartsocketapp/baseComponents/appWidgets.dart';
import 'package:smartsocketapp/routes/Routes.dart';
import 'bezierContainer.dart';

import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';

class WifiSetupInfoPage extends StatefulWidget {
  
  WifiSetupInfoPage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _WifiSetupInfoStatePage createState() => _WifiSetupInfoStatePage();
  
}

class _WifiSetupInfoStatePage extends State<WifiSetupInfoPage> {
  
  final String wifiInfoText = "For a seamless experience store your WiFi credentials on the App. \nYour credentials will only be stored on your device and not on any servers. \nYou can change your credentials anytime from your profile.";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: AppWidgets(context).appBarbackButton(() {
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
        }),
        titleSpan1: 'Smart',
        titleSpan2: 'Socket',
        appBar:AppBar(),      
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack (
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal:20),
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
                    wifiInfoText,
                    style: GoogleFonts.openSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppWidgets(context).customButton(
                        'Skip', 
                        Color(0xfff7892b),
                        (){ Navigator.of(context).pushNamed(Routes.home); },
                        gradientColors: [Colors.white,Colors.white],
                        width: MediaQuery.of(context).size.width/2.4
                      ),
                      AppWidgets(context).customButton(
                        'Proceed',
                        Colors.white, 
                        () { Navigator.of(context).pushNamed(Routes.wifiSetup); },
                        gradientColors: [Color(0xfffbb448), Color(0xfff7892b)],
                        width: MediaQuery.of(context).size.width/2.4
                      ),
                    ],
                  ),
                ]
              ),
            ),
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()
            )
          ],
        )
      ),
      
    );
  }
}