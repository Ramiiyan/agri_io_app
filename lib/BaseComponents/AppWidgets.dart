import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidgets {
  BuildContext context;
  // AppWidgets(BuildContext context) {
  //   this.context = context;
  // }
  AppWidgets(this.context);

  Widget backButton(VoidCallback onTapFunction) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
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
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
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
            textStyle: Theme.of(context).textTheme.displayLarge,
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              obscureText: isPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget customButton(
      String buttonLabel, Color labelColor, VoidCallback onTapFunction,
      {required List<Color> gradientColors, double width = 40}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
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
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Request Failed"),
      content: const Text("Your toggle request failed."),
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
