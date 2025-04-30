class EmpData {
  // Personal Information

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

  // Payment Information
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
    required this.paidBy,
    required this.accName,
    required this.accNumber,
    required this.baseSal,
  });

  // Convert the model to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'empId': empId,
      'fullname': fullname,
      'gender': gender,
      'dob': dob.toString(),
      'phone': phone,
      'email': email,
      'nationalId': nationalId,
      'typeEmp': typeEmp,
      'address': address,
      'startDate': startDate.toString(),
      'paidBy': paidBy,
      'accName': accName,
      'accNumber': accNumber,
      'baseSal': baseSal,
    };
  }

  // Create a model from a Firestore document
  factory EmpData.fromMap(Map<String, dynamic> map) {
    return EmpData(
      empId: map['empId'] ?? '',
      fullname: map['fullname'] ?? '',
      gender: map['gender'] ?? '',
      dob: DateTime.parse(map['dob'] ?? ''),
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      nationalId: map['nationalId'] ?? '',
      typeEmp: map['typeEmp'] ?? '',
      address: map['address'] ?? '',
      startDate: DateTime.parse(map['startDate'] ?? DateTime.now().toString()),
      paidBy: map['paidBy'] ?? '',
      accName: map['accName'] ?? '',
      accNumber: map['accNumber'] ?? '',
      baseSal: map['baseSal'] ?? '',
    );
  }
}
