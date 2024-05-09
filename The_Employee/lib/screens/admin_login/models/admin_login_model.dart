
class AdminLoginModel {
  final String email;
  final String password;

  AdminLoginModel({required this.email, required this.password});

  factory AdminLoginModel.fromMap(Map<String, dynamic> data) =>
      AdminLoginModel(email: data['email'], password: data['password']);

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
