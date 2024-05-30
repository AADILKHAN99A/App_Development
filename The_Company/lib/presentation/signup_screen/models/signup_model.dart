class SignupModel {
  String phone;
  String? sms;

  String? password;
  String? confirmPassword;

  String? inviteCode;

  SignupModel(
      {required this.phone,
       this.sms,
       this.password,
       this.confirmPassword,
       this.inviteCode});

  factory SignupModel.fromMap(Map<String, dynamic> data) => SignupModel(
      phone: data['phone'],
      sms: data['sms'],
      password: data['password'],
      confirmPassword: data['confirmPassword'],
      inviteCode: data['inviteCode']);

  Map<String, dynamic> toMap() => {
        'phone': phone,
        'sms': sms,
        'password': password,
        'confirmPassword': confirmPassword,
        'inviteCode': inviteCode
      };
}
