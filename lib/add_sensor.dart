import 'package:agri_io_app/BaseComponents/AppWidgets.dart';
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
                            AppWidgets(context).entryField("Sensor Name"),
                            AppWidgets(context).entryField("Sensor Type")
                          ])),
                    ]),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Row(children: [Icon(Icons.create), Text('Create')]),
        onPressed: submit,
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.sensorView, (route) => false);
    }
  }
}
