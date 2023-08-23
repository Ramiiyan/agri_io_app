class Sensor {
  String sensorName;
  String type;
  //double sensorValue; ##TODO

  Sensor(this.sensorName, this.type);

  factory Sensor.fromJson(dynamic json) {
    return Sensor(json['sensorName'] as String, json['type'] as String);
  }

  @override
  String toString() {
    return '{ $sensorName, $type }';
  }
}
