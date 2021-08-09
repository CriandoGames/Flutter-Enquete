import 'package:enquete/domain/entities/entities.dart';

import '../../domain/usercases/usercases.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  const RemoteAuthentication({required this.httpClient, required this.url});
  Future<void> auth(AutenticationParams params) async {
    await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAutenticationParams.fromDomain(params).toJson());
  }
}

class RemoteAutenticationParams {
  final String email;
  final String password;

  RemoteAutenticationParams({
    required this.email,
    required this.password,
  });

  factory RemoteAutenticationParams.fromDomain(AutenticationParams entity) =>
      RemoteAutenticationParams(email: entity.email, password: entity.password);

  Map toJson() => {'email': email, 'password': password};
}
