import 'package:agri_io_app/routes/Routes.dart';
import 'package:flutter/material.dart';

import 'BaseComponents/AppWidgets.dart';

class AddSensor extends StatefulWidget {
  AddSensor({Key? key}) : super(key: key);

  //final ValueChanged<String> onSubmit;

  @override
  AddSensorState createState() => AddSensorState();
}

class AddSensorState extends State<AddSensor> {
  final _controller = TextEditingController();
  var _text = '';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      const SizedBox(height: 50),
                      //AppWidgets(context).entryField(formKey, 'Name :'),
                      TextField(
                          controller: _controller,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Name :',
                            errorText: textValidation(),
                          ),
                          onChanged: (text) => setState(() => _text)),
                      const SizedBox(height: 10),
                    ]),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Row(children: [Icon(Icons.create), Text('Create')]),
        onPressed: _controller.value.text.isNotEmpty ? submit : null,
      ),
    );
  }

  void submit() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.sensorView, ModalRoute.withName(Routes.sensorView));
  }

  String? textValidation() {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
