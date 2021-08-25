import 'dart:async';

import 'package:enquete/domain/usercases/authentication.dart';

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
  bool isLoading = false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final Authentication authentication;
  var _state = LoginState();

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError ?? null).distinct();

  Stream<String?> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError ?? null).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  void _update() => _controller.add(_state);

  StreamLoginPresenter(
      {required this.validation, required this.authentication});
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

  Future<void>? auth() async {
    _state.isLoading = false;
    _update();
    await authentication.auth(
        AuthenticationParams(email: _state.email!, password: _state.password!));
    _state.isLoading = true;
    _update();
  }
}
