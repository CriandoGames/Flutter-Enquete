import '/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AutenticationParams params);
}

class AutenticationParams {
  final String email;
  final String password;

  AutenticationParams({
    required this.email,
    required this.password,
  });

  Map toJson() => {'email': email, 'password': password};
}
