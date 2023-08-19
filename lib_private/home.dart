import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:smartsocketapp/DeviceView.dart';
import 'package:smartsocketapp/baseComponents/Drawer.dart';
import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';
import 'package:smartsocketapp/routes/Routes.dart';

import 'baseComponents/AppWidgets.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super (key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _data = [
    {
      "name": "Test Device 1",
      "serial_number": "0000000001",
      "urn": "fc1d82c0-c4cd-42fe-b8f5-da0b44f86a73",
      "state": false,
      "device_type":"switch"
    },
    {
      "name": "Test Device 2",
      "serial_number": "0000000002",
      "urn": "89bdbfeb-9bc7-413c-94ae-4f61dce8641b",
      "state": false,
      "device_type":"button"
    },
    {
      "name": "AC Socket",
      "serial_number": "0000000003",
      "urn": "26930430-1e45-4250-8db1-8ffcb275708b",
      "state": false,
      "device_type":"socket"
    },
    {
      "name": "Kitchen Socket",
      "serial_number": "0000000004",
      "urn": "d6943300-1f35-3910-8db1-39fcd390200b",
      "state": false,
      "device_type":"socket"
    }
  ];

  Widget _buildList() {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index){
        var item = _data[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal:6.0),
          height: MediaQuery.of(context).size.height/8,
          child: Card (
            elevation: 5,
            child:InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context)=> DeviceViewPage(
                        // appBarTitle: item['name'],
                        device: item,
                      )
                    )
                  );
                },
              child:ListTile(
              title: Text(item['name']),
              subtitle: Text(item['serial_number']),
              trailing: Switch(
                value: item['state'],
                onChanged: (bool value) {
                  setState(() { item['state'] = value; });
                  _changeState(value, item['urn']);
                },
              ),
              ),
            ),
          )  
        );                    
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: null,
        titleSpan1: 'Home',
        titleSpan2: null,
        appBar: AppBar(),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.addDevice);
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Color(0xfff7892b),
      ),
    );
  }
}
