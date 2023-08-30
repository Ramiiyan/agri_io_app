import 'dart:convert';

import 'package:agri_io_app/Models/sensor_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String baseURL = "http://localhost:8080";

  Future<List<Sensor>> fetchSensors() async {
    Response res = await get(Uri.parse("$baseURL/sensors"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Sensor> sensors = body
          .map(
            (dynamic item) => Sensor.fromJson(item),
          )
          .toList();
      //return decodeSensors(res.body);
      return sensors;
    } else {
      throw Exception('Unable to fetch data from the REST API');
    }
  }

  // List<Sensor> decodeSensors(String responseBody) {
  //   List<dynamic> body = jsonDecode(responseBody);

  //   List<Sensor> sensors = body
  //       .map(
  //         (dynamic item) => Sensor.fromJson(item),
  //       )
  //       .toList();
  //   return sensors;
  // }
}
