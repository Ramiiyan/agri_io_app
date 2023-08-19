import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartsocketapp/BaseComponents/appWidgets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget leading;
  final String titleSpan1 ;
  final String titleSpan2;
  final Color span1Color;
  final Color span2Color;
  final List<Widget> actions;
  final AppBar appBar;

  const BaseAppBar({
    this.appBar,
    this.leading,
    this.titleSpan1= 'Smart',
    this.titleSpan2= '',
    this.span1Color= Colors.white,
    this.span2Color= Colors.black,
    this.actions,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: AppWidgets(context).title(
        titleSpan1,
        span2Text: titleSpan2,
        span1Color: span1Color,
        span2Color: span2Color
      ),
      actions: actions,
      // backgroundColor: Colors.white,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfff7892b), Color(0xfffbb448)]
          )
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}