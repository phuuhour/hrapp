class AdminAccount {
  final String adminId;
  final String fullname;
  final String phone;
  final String password;

  AdminAccount({
    required this.adminId,
    required this.fullname,
    required this.phone,
    required this.password,
  });

  factory AdminAccount.fromMap(Map<String, dynamic> map) {
    return AdminAccount(
      adminId: map['adminId'] ?? '',
      fullname: map['fullname'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'fullname': fullname,
      'phone': phone,
      'password': password,
    };
  }
}
