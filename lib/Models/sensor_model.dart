import 'package:flutter/foundation.dart';

class Sensor {
  final String sensorName;
  final String type;
  double? sensorValue;

  Sensor(this.sensorName, this.type, this.sensorValue);
  Sensor.withoutSensorValue({required this.sensorName, required this.type});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor.withoutSensorValue(
        sensorName: json['sensorName'] as String, type: json['type'] as String);
  }

  @override
  String toString() {
    return '{ $sensorName, $type }';
  }
}
