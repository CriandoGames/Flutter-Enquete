abstract class LoginPresenter {
  Stream<String>? get emailErrorStream;
  Stream<String>? get passwordErrorStream;
  Stream<bool>? get isFormValidStream;

  void auth();
  void validateEmail(String email);
  void validatePassword(String password);
}
