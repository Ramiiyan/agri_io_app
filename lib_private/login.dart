import 'package:flutter/material.dart';
import 'package:smartsocketapp/BaseComponents/appWidgets.dart';
import 'package:smartsocketapp/routes/Routes.dart';
import 'bezierContainer.dart';

class LoginPage extends StatefulWidget {
  
  LoginPage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _LoginStatePage createState() => _LoginStatePage();
}

class _LoginStatePage extends State<LoginPage> {

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.wifiSetupInfo,
          ModalRoute.withName(Routes.login)
        );
      },
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
            colors: [Color(0xfffbb448), Color(0xfff7892b)]
          )
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/signup',
                ModalRoute.withName('/') 
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _resetPassword(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: InkWell(
        child:Text(
        'Forgot Password ?',
        style:TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
        ),
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/resetPwd',
            ModalRoute.withName('/login')
          );
        },
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        AppWidgets(context).entryField('Email'),
        AppWidgets(context).entryField('Password', isPassword: true),
      ],
    );
  }

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
                      flex: 3,
                      child: SizedBox(),
                    ),
                    AppWidgets(context).title(
                      'Smart',
                      span2Text:'Socket',
                      span1Color:Color(0xffe46b10)
                    ),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    _resetPassword(),
                    _divider(),
                    _facebookButton(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _createAccountLabel(),
              ),
              Positioned(
                top: 40, 
                left: 0, 
                child: AppWidgets(context)
                  .backButton(() {
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }
                ),
              ),
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()
              )
            ],
          ),
        )
      )
    );
  }
}