import 'package:cloud_firestore/cloud_firestore.dart';

class EmpData {
  final String empId;
  final String fullname;
  final String gender;
  final DateTime dob;
  final String phone;
  final String email;
  final String nationalId;
  final String typeEmp;
  final String address;
  final DateTime startDate;
  final String branch;
  final String section;
  final String workname;
  final String paidBy;
  final String accName;
  final String accNumber;
  final String baseSal;

  EmpData({
    required this.empId,
    required this.fullname,
    required this.gender,
    required this.dob,
    required this.phone,
    required this.email,
    required this.nationalId,
    required this.typeEmp,
    required this.address,
    required this.startDate,
    required this.branch,
    required this.section,
    required this.workname,
    required this.paidBy,
    required this.accName,
    required this.accNumber,
    required this.baseSal,
  });

  factory EmpData.fromMap(Map<String, dynamic> map) {
    return EmpData(
      empId: map['empId'] ?? '',
      fullname: map['fullname'] ?? '',
      gender: map['gender'] ?? '',
      dob: (map['dob'] as Timestamp).toDate(),
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      nationalId: map['nationalId'] ?? '',
      typeEmp: map['typeEmp'] ?? '',
      address: map['address'] ?? '',
      startDate: (map['startDate'] as Timestamp).toDate(),
      branch: map['branch'] ?? '',
      section: map['section'] ?? '',
      workname: map['workname'] ?? '',
      paidBy: map['paidBy'] ?? '',
      accName: map['accName'] ?? '',
      accNumber: map['accNumber'] ?? '',
      baseSal: map['baseSal'] ?? '',
    );
  }
}
