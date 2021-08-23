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

  PostExpectation mockValidationCall({String? field}) =>
      when(validation.validation(field: field ?? 'field', email: 'value'));

  PostExpectation? mockValidation({String? field, String? value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('should call validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validation(field: 'email', email: email)).called(1);
  });

  test('should emit  error if validation fails', () {
    mockValidation(value: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
