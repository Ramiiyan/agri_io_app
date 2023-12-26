class Sensor {
  String? _sensorId;
  String _sensorName;
  String _type;
  double? _sensorValue;

  Sensor(this._sensorId, this._sensorName, this._type, this._sensorValue);
  Sensor.nonSensorValue(this._sensorId, this._sensorName, this._type);
  Sensor.nonSensorId(this._sensorName, this._type);
  //Sensor.withoutSensorValue({required this._sensorName, required this._type});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    print("Sensor: json : ${json['type']}");
    return Sensor(json['sensorId'] as String, json['sensorName'] as String,
        json['type'] as String, json['sensorValue'] as double);
  }

  factory Sensor.nonSensorValuefromJson(Map<String, dynamic> json) {
    return Sensor.nonSensorValue(json['sensorId'] as String,
        json['sensorName'] as String, json['type'] as String);
  }
  set setSensorId(String sensorId) {
    _sensorId = sensorId;
  }

  String get getSensorId {
    return _sensorId!;
  }

  set setSensorName(String sensorName) {
    _sensorName = sensorName;
  }

  String get getSensorName {
    return _sensorName;
  }

  set setType(String type) {
    _type = type;
  }

  String get getType {
    return _type;
  }

  set setSensorValue(double sensorValue) {
    _sensorValue = sensorValue;
  }

  double? get getSensorValue {
    return _sensorValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sensorName'] = _sensorName;
    data['type'] = _type;
    return data;
  }

  Map<String, dynamic> toJsonWithId() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sensorId'] = _sensorId;
    data['sensorName'] = _sensorName;
    data['type'] = _type;
    return data;
  }

  @override
  String toString() {
    return '{ "sensorId":"$_sensorId", "sensorName":"$_sensorName", "type":"$_type", "sensorValue":"$_sensorValue" }';
  }
}
