import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  const RemoteAuthentication({required this.httpClient, required this.url});
  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void>? request({
    required String url,
    required String method,
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

late HttpClientSpy httpClient;
late String url;
late RemoteAuthentication sut;

void main() {
  setUp(() {
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
  });

  test('shuld call httpClient with correct value', () async {
    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
