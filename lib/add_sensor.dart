import 'dart:convert';

import 'package:agri_io_app/BaseComponents/AppWidgets.dart';
import 'package:agri_io_app/Models/sensor_model.dart';
import 'package:agri_io_app/Services/HttpService.dart';
import 'package:agri_io_app/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSensor extends StatefulWidget {
  AddSensor({Key? key}) : super(key: key);

  //final ValueChanged<String> onSubmit;

  @override
  AddSensorState createState() => AddSensorState();
}

class AddSensorState extends State<AddSensor> {
  final _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  late String _newSensorName, _newSensorType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Sensor'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Text(
                        'Enter Your Sensor Details',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSans(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Sensor Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _newSensorName = value.toString();
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
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true)),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Sensor Type",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _newSensorType = value.toString();
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
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true)),
                                ],
                              ),
                            ),
                          ])),
                    ]),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Row(children: [Icon(Icons.create), Text('Create')]),
        onPressed: _submit,
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_mySnackBar("Data Processing..", color: Colors.black));

      final res = await httpService
          .createSensor(Sensor.nonSensorId(_newSensorName, _newSensorType));

      final Map<String, dynamic> jsonResponse = jsonDecode(res);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (jsonResponse['statusCode'] == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(_mySnackBar("Created Successfully."));
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.sensorView, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(_mySnackBar(
            "Failed to create. Try again.",
            due: 10,
            color: Colors.red));
      }
    }
  }

  SnackBar _mySnackBar(String msg,
      {int due = 3, Color color = const Color.fromARGB(255, 59, 197, 64)}) {
    final scaff = ScaffoldMessenger.of(context);

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: due),
      clipBehavior: Clip.antiAlias,
      action: SnackBarAction(
        label: 'CLOSE',
        onPressed: scaff.hideCurrentSnackBar,
      ),
    );
    return snackBar;
  }
}
