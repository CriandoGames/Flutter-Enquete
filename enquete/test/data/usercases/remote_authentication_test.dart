import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:enquete/domain/helpers/helpers.dart';
import 'package:enquete/domain/usercases/usercases.dart';

import 'package:enquete/data/http/http.dart';
import 'package:enquete/data/usercases/usercases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

late HttpClientSpy httpClient;
late String url;
late RemoteAuthentication sut;
late AutenticationParams params;
void main() {
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AutenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
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
  test('shuld throw UnexpectedError if httpClient return 400', () async {

  
    when(httpClient.request(
        url: anyNamed('url'),
        method:  anyNamed('method'),
        body: anyNamed('body'))).thenThrow(HttpError.badRequest);

    final params = AutenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));

  });


    test('shuld throw UnexpectedError if httpClient return 404', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method:  anyNamed('method'),
        body: anyNamed('body'))).thenThrow(HttpError.notFound);

    final params = AutenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));

  });

     test('shuld throw UnexpectedError if httpClient return 500', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method:  anyNamed('method'),
        body: anyNamed('body'))).thenThrow(HttpError.serverError);

    final params = AutenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));

  });
}
