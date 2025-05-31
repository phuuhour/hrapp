class AdminAccount {
  final String adminId;
  final String fullname;
  final String phone;
  final String password;
  String imgUrl;

  AdminAccount({
    required this.adminId,
    required this.fullname,
    required this.phone,
    required this.password,
    required this.imgUrl,
  });

  factory AdminAccount.fromMap(Map<String, dynamic> map) {
    return AdminAccount(
      adminId: map['adminId'] ?? '',
      fullname: map['fullname'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'fullname': fullname,
      'phone': phone,
      'password': password,
      'imgUrl': imgUrl,
    };
  }
}
