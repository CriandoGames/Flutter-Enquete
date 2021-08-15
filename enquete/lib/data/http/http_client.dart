abstract class HttpClient {
  Future<Map?> request({
    required String url,
    String? method,
    Map? body,
  });
}
