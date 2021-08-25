import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:enquete/ui/presentation/presentation.dart';
import 'package:enquete/ui/presentation/protocols/validation.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;
  late String password;

  PostExpectation mockValidationCall({String? field}) =>
      when(validation.validation(field: field ?? 'field', email: 'value'));

  PostExpectation? mockValidation({String? field, String? value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });

  test('should call validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validation(field: 'email', email: email)).called(1);
  });

  test('should emit error if validation fails', () {
    mockValidation(value: 'error');

    /*  sut.emailErrorStream
        .listen(expectAsync1((error) => {expect(error, 'error')})); */ //NULL

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => {expect(isValid, false)}));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('should emit null if validation succeed', () {
    sut.emailErrorStream.listen(expectAsync1((error) => {expect(error, null)}));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => {expect(isValid, false)}));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('should  emit error if validation fails with password', () {
    sut.validatePassword(password);

    verify(validation.validation(field: 'password', email: password)).called(1);
  });

  test('should call validation with password', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => {expect(error, null)}));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => {expect(isValid, false)}));

    sut.validateEmail(password);
    sut.validateEmail(password);
  });

  test('should emit password error if validation with fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => {expect(error, null)}));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => {expect(error, null)}));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => {expect(isValid, false)}));

    sut.validateEmail(email);
    sut.validateEmail(password);
  });
}
