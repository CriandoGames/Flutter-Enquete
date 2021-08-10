import '../../domain/usercases/usercases.dart';
import '../models/models.dart';

import '/domain/entities/entities.dart';
import '/domain/helpers/helpers.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  const RemoteAuthentication({required this.httpClient, required this.url});

  Future<AccountEntity?>? auth(AutenticationParams params) async {
    final body = RemoteAutenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);

      if (httpResponse != null)
        return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
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
