import 'dart:convert';

import 'package:agri_io_app/Models/sensor_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseURL = "http://localhost:8080";
  late http.Response httpResponse;

  Future<List<Sensor>> fetchSensors() async {
    try {
      final response = await http.get(Uri.parse("$baseURL/sensors"));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
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
    } catch (e) {
      throw Exception('error: $e');
    }
  }

  Future<String> createSensor(Sensor sensor) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/addSensor"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(sensor.toJson()),
      );

      final res = jsonEncode(<String, dynamic>{
        'requestBody': jsonEncode(sensor.toJson()),
        'statusCode': response.statusCode,
        'responseBody': response.body
      });
      //print(res);

      return res;
    } catch (e) {
      throw Exception('error: $e');
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
