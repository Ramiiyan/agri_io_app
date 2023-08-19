import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartsocketapp/NameDevice.dart';
import 'package:smartsocketapp/baseComponents/AppWidgets.dart';
import 'package:smartsocketapp/baseComponents/BaseAppBar.dart';

class AddDevicePage extends StatefulWidget{
  final String title;
  AddDevicePage({Key key, this.title}) : super(key: key);
  
  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  var _deviceType =[
    {
      "name": "Smart Socket",
      "imgUrl": "assets/Images/ss_socket.png"
    },
    {
      "name": "Smart Button",
      "imgUrl": "assets/Images/ss_button.png"
    },
    {
      "name": "Smart Switch",
      "imgUrl": "assets/Images/ss_switch.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: AppWidgets(context).appBarbackButton(() { 
          Navigator.of(context).pop();
        }),
        titleSpan1: 'Add New Device',
        titleSpan2: null,
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildList()
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _deviceType.length,
      itemBuilder: (BuildContext context, int index){
        var item = _deviceType[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal:6.0),
          height: MediaQuery.of(context).size.height/8,
          child: Card (
            elevation: 5,
            child:InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => NameDevicePage(deviceType: item)
                    )
                  );
                },
              child:Container(
                margin: EdgeInsets.symmetric(vertical:15.0),
                child:ListTile(
                  leading: Image.asset(item['imgUrl']),
                  title: Text(item['name']),
                ),
              ),
            ),
          )  
        );
      }
    );
  }

}