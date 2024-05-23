import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeDataModel {
  final String fullName;
  final String email;

  final String phone;
  final String workDetails;

  final DateTime joinDate;

  final bool isActive;

  final String? aboutMe;
  final List<dynamic> skills;

  EmployeeDataModel(
      {required this.fullName,
      required this.email,
      required this.phone,
      required this.workDetails,
      required this.joinDate,
      required this.isActive,
      this.aboutMe="",
      required this.skills});

  factory EmployeeDataModel.fromMap(Map<String, dynamic> data) =>
      EmployeeDataModel(
          fullName: data['fullName'],
          email: data['email'],
          phone: data['phone'],
          workDetails: data['workDetails'],
          joinDate: (data['joinDate'] as Timestamp).toDate(),
          isActive: data['isActive'],
          aboutMe: data['aboutMe'],
          skills: (data['skills'] as List<dynamic>));

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'workDetails': workDetails,
      'joinDate': joinDate,
      'isActive': isActive,
      'aboutMe': aboutMe,
      'skills': skills
    };
  }
}