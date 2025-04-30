import 'package:cloud_firestore/cloud_firestore.dart';

class SectionData {
  String sectionName;

  SectionData({required this.sectionName});

  // Convert a Section object to a Map
  Map<String, dynamic> toMap() {
    return {'sectionName': sectionName};
  }

  // Create a Section object from a Map
  factory SectionData.fromMap(Map<String, dynamic> map) {
    return SectionData(sectionName: map['sectionName'] ?? '');
  }

  // Create a Section object from a Firestore document
  factory SectionData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SectionData.fromMap(data);
  }
}
