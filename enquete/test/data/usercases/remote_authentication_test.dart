import 'package:enquete/domain/entities/entities.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:enquete/domain/helpers/helpers.dart';
import 'package:enquete/domain/usercases/usercases.dart';

import 'package:enquete/data/http/http.dart';
import 'package:enquete/data/usercases/usercases.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientSpy extends Mock implements HttpClient {}

late HttpClientSpy httpClient;
late String url;
late RemoteAuthentication sut;
late AuthenticationParams params;

mockRequest() => when(
      () => httpClient.request(
        url: any(named: 'url', that: isNotNull),
        method: any(named: 'method', that: isNotNull),
        body: any(named: 'body', that: isNotNull),
      ),
    );

Map mockValidData() =>
    {'accessToken': faker.guid.guid(), 'name': faker.person.name()};
void main() {
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
  });

  test('shuld call httpClient with correct value', () async {
    mockRequest().thenAnswer((_) async => mockValidData());

    await sut.auth(params);

    verify(() => httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.password}));
  });
  test('shuld throw UnexpectedError if httpClient return 400', () async {
    mockRequest().thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('shuld throw UnexpectedError if httpClient return 404', () async {
    mockRequest().thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('shuld throw UnexpectedError if httpClient return 500', () async {
    mockRequest().thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('shuld throw InvalidCredentialsError if httpClient return 401',
      () async {
    mockRequest().thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('shuld return an Account if httpClient return 20', () async {
    final accessToken = faker.guid.guid();

    mockRequest().thenAnswer((_) async => {
          'accessToken': accessToken,
          'name': faker.person.name(),
        });

    final account = await sut.auth(params) ?? AccountEntity('null');

    expect(account.token, accessToken);
  });

  test(
      'should throw UnexpectedError if httpClient return 200 with invalid data',
      () async {
    mockRequest().thenAnswer((_) async => {
          'invalid_key': faker.guid.guid(),
          'name': faker.person.name(),
        });

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
