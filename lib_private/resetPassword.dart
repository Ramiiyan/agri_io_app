import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartsocketapp/BaseComponents/appWidgets.dart';
import 'bezierContainer.dart';

class ResetPasswordPage extends StatefulWidget {

  ResetPasswordPage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _ResetPasswordStatePage createState() => _ResetPasswordStatePage();
}

class _ResetPasswordStatePage extends State<ResetPasswordPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        AppWidgets(context).title(
                          'Smart', //span1Text (mandatory)
                          span2Text:'Socket',
                          span1Color:Color(0xffe46b10)
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Forgot Your Password?',
                              style: GoogleFonts.portLligatSans(
                                textStyle: Theme.of(context).textTheme.headline1,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffe46b10), 
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _emailField(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 40, 
                    left: 0, 
                    child: AppWidgets(context)
                      .backButton(() {
                        print('reset back');
                        Navigator.of(context).pushNamed('/login');
                      })
                  ),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )
        )
    );
  }

  Widget _emailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
            )
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
          //  ON RESET
      // onTap: () {
      //   Navigator.of(context).pushNamedAndRemoveUntil(
      //     '/home',
      //     ModalRoute.withName('/login')
      //   );
      // },

      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
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
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Reset Password',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
  
}