import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class HttpAdapter {
  final GetConnect client;
  const HttpAdapter(this.client);

  Future<void> request(
      {required String url,
      required String method,
      required Map body,
      Map<String, String> headers = const {
        'content-type': 'application/json',
        'accept': 'application/json'
      }}) async {
    try {
      await client.post(url, body, headers: headers);
    } catch (e) {
      print(e);
    }
  }
}

class GetConnectSpy extends Mock implements GetConnect {}

void main() {
  late HttpAdapter sut;
  late GetConnectSpy client;
  late String url;

  setUp(() {
    client = GetConnectSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('POST', () {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    test('should call post with correct url,body,headers', () async {
      var body = {'any': 'any'};
      await sut.request(url: url, method: 'post', body: body);

      verify(() => client.post(url, body, headers: headers));
    });
  });
}
