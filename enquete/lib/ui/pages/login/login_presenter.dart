abstract class LoginPresenter {
  Stream<String>? get emailErrorStream;
  Stream<String>? get passwordErrorStream;
  Stream<String>? get mainErrorController;
  Stream<bool>? get isFormValidStream;
  Stream<bool>? get isLoadingController;

  void auth();
  void validateEmail(String email);
  void validatePassword(String password);
  void dispose();
}
