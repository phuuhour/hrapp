class EmpAccount {
  final String empId;
  final String fullname;
  final String phone;
  final String password;

  EmpAccount({
    required this.empId,
    required this.fullname,
    required this.phone,
    required this.password,
  });

  factory EmpAccount.fromMap(Map<String, dynamic> map) {
    return EmpAccount(
      empId: map['empId'] ?? '',
      fullname: map['fullname'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'empId': empId,
      'fullname': fullname,
      'phone': phone,
      'password': password,
    };
  }
}
