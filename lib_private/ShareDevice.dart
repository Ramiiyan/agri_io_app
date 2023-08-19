import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';
import 'package:smartsocketapp/baseComponents/appWidgets.dart';
import 'package:smartsocketapp/routes/Routes.dart';

class ShareDevicePage extends StatefulWidget {
  
  ShareDevicePage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _ShareDeviceStatePage createState() => _ShareDeviceStatePage();
  
}

class _ShareDeviceStatePage extends State<ShareDevicePage> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BaseAppBar is own class implements appBar
      appBar: BaseAppBar(
        leading:AppWidgets(context).appBarbackButton(() {
          Navigator.of(context).pop();
        }),
        titleSpan1: 'Share Device',
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: IconButton (
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.sharePermission);
              },
              icon:Icon(
                Icons.settings,
                size: 32.0,
              ),
            ),
          ),
        ],
        appBar: AppBar(), //using same preference of appBar
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
                    'Share Your Device with Others.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: Theme.of(context).textTheme.headline5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 40),
                  AppWidgets(context).entryField('Email'),
                  SizedBox(height: 30),
                  _button(
                    'Share',
                    Colors.black, 
                    () { 
                      print('Device Shared !');
                    },
                    gradientColors:[Color(0xfffbb448), Color(0xfff7892b)]
                  )
                ]
              ),
            ),
          ],
        )
      ),
      
    );
  }
  Widget _button(String buttonLabel,Color labelColor, void Function() onTapFunction,  {List<Color> gradientColors}) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: gradientColors,
        )
      ),
      child: InkWell(
        onTap: onTapFunction,
        splashColor: Colors.white38,
        child: Container(
          width: MediaQuery.of(context).size.width/2.4,
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