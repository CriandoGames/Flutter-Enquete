import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final GetConnectInterface client;
  HttpAdapter(this.client);

  Future<Map?> request({
    required String url,
     String? method,
    Map? body,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
    
    var response = Response(body: '', statusCode: 500);
    try {
      if (method == 'post') {
        response = await client.post(url, body, headers: headers);
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

   dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
