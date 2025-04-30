import 'package:cloud_firestore/cloud_firestore.dart';

class WorkData {
  final String id;
  final String workId;
  final String section;
  final String workName;
  final DateTime createDate;
  final DateTime startDate;
  final String branch;
  final double payroll;

  WorkData({
    required this.id,
    required this.workId,
    required this.section,
    required this.workName,
    required this.startDate,
    required this.branch,
    required this.payroll,
    required this.createDate,
  });

  // Convert the model to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workId': workId,
      'section': section,
      'workName': workName,
      'startDate': startDate,
      'branch': branch,
      'payroll': payroll,
      'createDate': createDate,
    };
  }

  // Create a model from a Firestore document
  factory WorkData.fromMap(Map<String, dynamic> map) {
    return WorkData(
      id: map['id'] ?? '',
      workId: map['workId'] ?? '',
      section: map['section'] ?? '',
      workName: map['workName'] ?? '',
      startDate:
          map['startDate'] != null
              ? (map['startDate'] as Timestamp).toDate()
              : DateTime.now(),
      branch: map['branch'] ?? '',
      payroll: (map['payroll'] ?? 0.0).toDouble(),
      createDate:
          map['createDate'] != null
              ? (map['createDate'] as Timestamp).toDate()
              : DateTime.now(),
    );
  }
}
