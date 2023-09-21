import 'dart:convert';

import 'package:agri_io_app/Models/sensor_model.dart';

class SocketDto {
  String _socketType;
  List<Sensor> _socketSensorList;

  SocketDto(this._socketType, this._socketSensorList);

  factory SocketDto.fromJson(Map<String, dynamic> jsonData) {
    print("SocketDto: jsonData['message'] : ${jsonData['message']}");
    List<dynamic> dataPayload = jsonDecode(jsonData['message']);
    List<Sensor> mqttResSensors = dataPayload
        .map(
          (dynamic item) => Sensor.fromJson(item),
        )
        .toList();

    return SocketDto(jsonData['type'] as String, mqttResSensors);
  }

  set setSocketType(String socketType) {
    _socketType = socketType;
  }

  String get geSocketType {
    return _socketType;
  }

  set setSocketSensorList(List<Sensor> socketSensorList) {
    _socketSensorList = socketSensorList;
  }

  List<Sensor> get getSocketSensorList {
    return _socketSensorList;
  }
}
