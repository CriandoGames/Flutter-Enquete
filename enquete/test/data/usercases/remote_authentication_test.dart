import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:enquete/domain/usercases/usercases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  const RemoteAuthentication({required this.httpClient, required this.url});
  Future<void> auth(AutenticationParams params) async {
    final body = {'email': params.email, 'password': params.password};
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void>? request(
      {required String url, required String method, Map? body});
}

class HttpClientSpy extends Mock implements HttpClient {}

late HttpClientSpy httpClient;
late String url;
late RemoteAuthentication sut;

void main() {
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('shuld call httpClient with correct value', () async {
    final params = AutenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.password}));
  });
}
