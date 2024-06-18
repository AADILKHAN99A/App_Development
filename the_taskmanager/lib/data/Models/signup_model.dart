class SignUpModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  SignUpModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'password': password};
  }

  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) => SignUpModel(
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      password: jsonData['password']);
}

class SignUpGoogleLoginModel{
  final String email;

  SignUpGoogleLoginModel(this.email);
}
