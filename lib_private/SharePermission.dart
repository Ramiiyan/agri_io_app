import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';
import 'package:smartsocketapp/baseComponents/appWidgets.dart';

class SharePermissionPage extends StatefulWidget {
  
  SharePermissionPage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _SharePermissionStatePage createState() => _SharePermissionStatePage();
  
}

class _SharePermissionStatePage extends State<SharePermissionPage> {
  Map <String,bool> permissions ={
    "ON" : true,
    "OFF" : false 
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BaseAppBar is own class implements appBar
      appBar: BaseAppBar(
        leading:AppWidgets(context).appBarbackButton(() {
          Navigator.of(context).pop();
        }),
        titleSpan1: 'Device Permissions',
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
                    'Select What the User Can Do?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: Theme.of(context).textTheme.headline5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container (
                    height: MediaQuery.of(context).size.height/3,
                    child: ListView (
                      children: permissions.keys.map((String key){
                        return CheckboxListTile(
                          title: Text(key),
                          value: permissions[key], 
                          onChanged: (bool value) {
                            setState((){
                              permissions[key] = value;
                            });
                          }
                        );
                      }).toList(),
                    )
                  ),
                ]
              ),
            ),
          ],
        )
      ),
    );
  }
}