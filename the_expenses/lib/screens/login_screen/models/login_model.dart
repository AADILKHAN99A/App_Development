class LoginModel {
  final String email;

  final String password;

  LoginModel(this.email, this.password);

  factory LoginModel.fromMap(Map<String, dynamic> data) =>
      LoginModel(data['email'], data['password']);

  Map<String, dynamic> toMap() => {'email': email, 'password': password};
}
