import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartsocketapp/baseComponents/AppWidgets.dart';
import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smartsocketapp/routes/Routes.dart';

class DeviceViewPage extends StatefulWidget {
  
  DeviceViewPage({Key key, this.device}) : super (key: key);

  final Map<String, Object> device; //hv to change into class

  @override
  _DeviceViewPageState createState() => _DeviceViewPageState();

}

class _DeviceViewPageState extends State<DeviceViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading:AppWidgets(context).appBarbackButton(() { 
          Navigator.of(context).pop();
        }),
        titleSpan1:widget.device['name'],
        titleSpan2:null,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {showDeleteAlertDialog();},
              icon:Icon(
                Icons.delete,
                size: 32.0,
              ),
            ),
          ),
        ],
        appBar: AppBar(),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _shareScheduleWidgets(context),
              SizedBox(height: 20),
              _imageSwitchWidget(context),
              SizedBox(height: 40),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _deviceDataRow('Serial No : ', widget.device['serial_number']),
                    SizedBox(height:5),
                    _deviceDataRow('Type : ', widget.device['device_type']),
                  ],
                ),
              ),
              
            ],
          )
        ),
      ),
    );
  }

  Widget _shareScheduleWidgets(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _iconBase(
            Icons.share,
            onPressed: () => Navigator.of(context).pushNamed(Routes.shareDevice),
          ),
          _iconBase(Icons.schedule)
        ],
      ),
    );
  }

  Widget _iconBase(IconData icon,{VoidCallback onPressed}){
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.black87,
        size: 38.0,
      ), 
      onPressed: onPressed
    );
  }

  Widget _imageSwitchWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _imageShift(widget.device['device_type']),
          Switch.adaptive(
            value: widget.device['state'],
            onChanged: (bool value) {
              setState(() { widget.device['state'] = value; });
              _changeState(value, widget.device['urn']);
            },
          ),
        ]  
      ),
    );
  }
  Widget _imageShift(String type){
    String imgType = 'assets/Images/ss_socket.png';
    switch (type){
      case 'socket': { imgType = 'assets/Images/ss_socket.png'; } break;
      
      case 'switch': { imgType = 'assets/Images/ss_switch.png'; } break;
      
      case 'button': { imgType = 'assets/Images/ss_button.png'; } break;
    }
    return Image.asset(imgType, width:150);
  }

  Widget _deviceDataRow(String label,String value){
    return Row(
      children: <Widget>[
        Text(
          label,
          style: GoogleFonts.nunitoSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 24,
            color: Colors.black,
          )
        ),
        Text(
          value,
          style: GoogleFonts.nunitoSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 22,
            color: Colors.black,
          )
        ),
      ],
    );
  }

  _changeState(bool state, String urn) async {
    String desired;
    String url = 'http://socket.abydub.com/althinect/things/' + urn + '/shadow/update';
    if (state) {
      desired = "on";
    } else {
      desired = "false";
    }
    final http.Response response = await http.put(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'state': {
          'desired': {
            "state": desired
          }
        }
      })
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
    } else {
      AppWidgets(context).showAlertDialog();
    }
  }

  showDeleteAlertDialog() {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove Device"),
      content: Text("Are You Sure You Want to Remove this Item?"),
      actions: [      
          AppWidgets(context).customButton(
            'NO',
            Colors.white, 
            () => Navigator.of(context).pop(),
            gradientColors: [Color(0xfffbb448), Color(0xfff7892b)],
            width: MediaQuery.of(context).size.width/3.4
          ),
          AppWidgets(context).customButton(
            'Yes',
            Colors.white, 
            () {print('Item Removed.');},
            gradientColors: [Color(0xffd32f2f), Color(0xffb71c1c)],
            width: MediaQuery.of(context).size.width/3.4
          ),
      ]
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
