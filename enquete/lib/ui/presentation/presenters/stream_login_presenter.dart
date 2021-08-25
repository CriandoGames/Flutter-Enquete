import 'dart:async';

import '../protocols/protocols.dart';

class LoginState {
  String? emailError;
  String? email;
  String? passwordError;
  String? password;
  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError ?? null).distinct();

  Stream<String?> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError ?? null).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  void _update() => _controller.add(_state);

  StreamLoginPresenter({required this.validation});
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validation(field: 'email', email: email);
    _update();
  }

  void validatePassword(String password) {
     _state.password = password;
    _state.passwordError =
        validation.validation(field: 'password', email: password);
    _update();
  }
}
