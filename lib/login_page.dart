import 'package:agri_io_app/sensor_view.dart';
import 'package:flutter/material.dart';
import '../routes/Routes.dart';
import 'Cards/internalClass.dart';
import 'my_global.dart' as global;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  late String _username, _password;
  bool _passwordVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Image.asset(
                  ImgSample.get("agri.io_logo.png"),
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
                const Text(
                  "Agri.IO",
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'AzoftSans',
                      color: Color.fromRGBO(28, 88, 57, 1),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Form(
                            key: _loginFormKey,
                            child: Column(children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            _username = value.toString();
                                            global.hostname = _username;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "USERNAME",
                                          prefixIcon: Icon(Icons.person),
                                        )),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    TextFormField(
                                        obscureText: _passwordVisible,
                                        onChanged: (value) {
                                          setState(() {
                                            _password = value.toString();
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            labelText: "PASSWORD",
                                            prefixIcon: const Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _passwordVisible =
                                                        !_passwordVisible;
                                                  });
                                                },
                                                icon: Icon(_passwordVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility)))),
                                  ],
                                ),
                              ),
                            ])),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.sensorView);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             SensorViewPage(hostname: _username)));
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                )
              ],
            )));
  }
}
