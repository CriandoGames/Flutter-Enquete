import '../../domain/usercases/usercases.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  const RemoteAuthentication({required this.httpClient, required this.url});
  Future<void> auth(AutenticationParams params) async {
    await httpClient.request(url: url, method: 'post', body: params.toJson());
  }
}
