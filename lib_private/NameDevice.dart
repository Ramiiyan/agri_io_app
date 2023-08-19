import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartsocketapp/baseComponents/AppWidgets.dart';
import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';
import 'package:smartsocketapp/routes/Routes.dart';

class NameDevicePage extends StatefulWidget {
  
  NameDevicePage({Key key, this.title, @required this.deviceType}) : super(key:key);

  final String title;
  final Map<String, Object> deviceType;

  @override
  _NameDeviceStatePage createState() => _NameDeviceStatePage();
  
}

class _NameDeviceStatePage extends State<NameDevicePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //BaseAppBar is own class implements appBar
      appBar: BaseAppBar(
        leading:AppWidgets(context).appBarbackButton(() {
          Navigator.of(context).pop();
        }),
        titleSpan1: 'Name The Device',
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
                  SizedBox(height: 10),
                  Image.asset(
                    widget.deviceType['imgUrl'].toString(),
                    width: 150,
                  ),
                  SizedBox(height: 50),
                  AppWidgets(context).entryField('Name :'),
                  SizedBox(height: 10),
                  AppWidgets(context).customButton(
                    'OK',
                    Colors.black, 
                    () { 
                      print(' New Device Created !');
                      Navigator.of(context).pushNamedAndRemoveUntil(Routes.addDevice, ModalRoute.withName(Routes.home));
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
}