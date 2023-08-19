import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartsocketapp/BaseComponents/AppWidgets.dart';
import 'package:smartsocketapp/routes/Routes.dart';

class AppDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
        child: Drawer(
          child: ListView(
            // padding: EdgeInsets.symmetric(horizontal:20),
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/8,
                child: _drawerHeader(context),
              ),
              _drawerItem(
                icon: Icons.account_circle,
                itemTitle: 'Profile'
              ),
              _drawerItem(
                icon: Icons.exit_to_app,
                itemTitle:'LogOut',
                onTap:()=>Navigator.of(context).pushNamedAndRemoveUntil( Routes.welcome, (route) => false)
              )
          ],
        ),
      )
    );
  }

  Widget _drawerHeader(BuildContext context) {
    return DrawerHeader(
      child:AppWidgets(context).title('Smart',span2Text: 'Socket'),
      decoration: BoxDecoration(
        color: Color(0xfff7892b),
      ),
    );
  }
  Widget _drawerItem({IconData icon, String itemTitle, GestureTapCallback onTap}){
    return ListTile(
      title: Row (
        children: <Widget>[
          Icon(icon),
          Padding (
            padding: EdgeInsets.only(left:8.0),
            child: Text(itemTitle),
          )
        ],
      ),
      onTap: onTap,
    );
    
  }
}