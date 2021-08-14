import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final GetConnect client;
  const HttpAdapter(this.client);

  Future<Map?>? request({
    required String url,
    String? method,
    Map? body,
  }) async {
    Map<String, String> headers = const {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    try {
      final response = await client.post(url, body, headers: headers);

      if (response.statusCode == 200) {
        return response.body.isBlank ? null : jsonDecode(response.body);
      } else if (response.statusCode == 204) {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
