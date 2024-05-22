import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';

class AdminPanelModel extends EmployeeDataModel {
  AdminPanelModel(
      {required this.id,
      required super.fullName,
      required super.email,
      required super.phone,
      required super.workDetails,
      required super.joinDate,
      required super.isActive,
      required super.skills,
      required super.aboutMe});

  final String id;

  factory AdminPanelModel.fromMap(Map<String, dynamic> data, String id) =>
      AdminPanelModel(
          fullName: data['fullName'],
          email: data['email'],
          phone: data['phone'],
          workDetails: data['workDetails'],
          joinDate: (data['joinDate'] as Timestamp).toDate(),
          isActive: data['isActive'],
          id: id,
          skills: data['skills'] as List<dynamic>,
          aboutMe: data['aboutMe']);

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'workDetails': workDetails,
      'joinDate': joinDate,
      'isActive': isActive,
      'id': id,
      'skills': skills,
      'aboutMe': aboutMe
    };
  }
}
