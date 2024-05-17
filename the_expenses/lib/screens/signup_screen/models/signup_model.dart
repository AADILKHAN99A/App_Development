class SignUpModel {
  final int? id;
  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String? password;

  SignUpModel(
      {this.id,
      required this.userId,
      required this.name,
      required this.email,
      required this.phone,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      UserTableFields.columnID: id,
      UserTableFields.columnUserId: userId,
      UserTableFields.columnName: name,
      UserTableFields.columnEmail: email,
      UserTableFields.columnPhone: phone,
      UserTableFields.columnPassword: password
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> jsonData) => SignUpModel(
      id: jsonData[UserTableFields.columnID],
      userId: jsonData[UserTableFields.columnUserId],
      name: jsonData[UserTableFields.columnName],
      email: jsonData[UserTableFields.columnEmail],
      phone: jsonData[UserTableFields.columnPhone],
      password: jsonData[UserTableFields.columnPassword]);

  SignUpModel copy(
          {int? id,
          String? userId,
          String? name,
          String? email,
          String? phone,
          String? password}) =>
      SignUpModel(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          name: name ?? this.name,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          password: password ?? this.password);
}

class UserTableFields {
  static const List<String> values = [
    columnID,
    columnUserId,
    columnName,
    columnEmail,
    columnPhone,
    columnPassword
  ];

  static const String userTable = 'UserTable';
  static const String columnID = "_id";
  static const String idType = 'INTEGER PRIMARY KEY';
  static const String columnName = "name";
  static const String nameType = 'TEXT NOT NULL';
  static const String columnUserId = "userid";
  static const String userIdType = 'TEXT NOT NULL';
  static const String columnEmail = "email";
  static const String emailType = 'TEXT NOT NULL';
  static const String columnPhone = "phone";
  static const String phoneType = 'TEXT';
  static const String columnPassword = "password";
  static const String passwordType = 'TEXT';
}
