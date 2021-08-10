class AccountEntity {
  final String token;

  const AccountEntity(this.token);

  factory AccountEntity.fromJson(Map json) =>
      AccountEntity(json['accessToken']);
}
