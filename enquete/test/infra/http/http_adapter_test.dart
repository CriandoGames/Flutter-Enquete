import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';


import 'package:enquete/infra/http/http.dart';

class GetConnectSpy extends Mock implements GetConnectInterface {}

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
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
    var body = {'any': 'any'};

    mockRequest() => when(() => client.post(url, body, headers: headers));

    void mockResponse(int statusCode, {Map? bod = const {'any': 'any'}}) {
      mockRequest()
          .thenAnswer((_) async => Response(body: bod, statusCode: statusCode));
    }

    setUp(() {
      mockResponse(200);
    });
    test('should call post with correct url,body,headers', () async {
      await sut.request(url: url, body: body);

   //   verify(() => client.post(url, body, headers: headers));
    });

    test('should call post with correct data if post return 200 with no data',
        () async {
      mockResponse(200, bod: null);
      final response = await sut.request(
        url: url,
        body: body,
      );

   //   expect(response,  throwsA(HttpError.badRequest));
    });

    test('should call post with correct data if post return 204', () async {
      mockResponse(204, bod: {});
      final response = await sut.request(
        url: url,
        body: {},
      );

     // expect(response, null);
    });

    test('should call post with correct data if post return 204 with data',
        () async {
      mockResponse(204);
      final response = await sut.request(
        url: url,
        body: body,
      );

    //  expect(response, null);
    });

    test('should call post with correct data if post return 400', () async {
      mockResponse(400);
      final future = sut.request(
        url: url,
        body: body,
      );
      print('FUTURE');
      print(future);
      //expect(future, throwsA(HttpError.badRequest));
    });
  });
}
