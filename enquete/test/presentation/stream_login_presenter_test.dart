import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String? validation({required field, required email});
}

class LoginState {
   late String? emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError ?? 'error');

  StreamLoginPresenter({required this.validation});
  void validateEmail(String email) {
    _state.emailError = validation.validation(field: 'email', email: email);
    _controller.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;
  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('should call validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validation(field: 'email', email: email)).called(1);
  });

  test('should emit  error if validation fails', () {
    when(validation.validation(field: 'field', email: 'value'))
        .thenReturn('error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
