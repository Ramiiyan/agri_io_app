import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidgets {
  BuildContext context;
  AppWidgets(BuildContext context) {
    this.context = context;
  }
  Widget backButton(VoidCallback onTapFunction) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget appBarbackButton(VoidCallback onTapFunction) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget title(String span1Text,
      {String span2Text = '',
      Color span1Color = Colors.white,
      Color span2Color = Colors.black}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: span1Text,
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            // color: Color(0xffe46b10),
            color: span1Color,
          ),
          children: [
            TextSpan(
              text: span2Text,
              style: TextStyle(color: span2Color, fontSize: 30),
            ),
          ]),
    );
  }

  Widget entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget customButton(
      String buttonLabel, Color labelColor, VoidCallback onTapFunction,
      {List<Color> gradientColors, double width = 40}) {
    return Container(
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
          width: width,
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

  showAlertDialog() {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Request Failed"),
      content: Text("Your toggle request failed."),
      actions: [
        okButton,
      ],
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
