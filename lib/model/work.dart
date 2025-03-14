class Work {
  final String section;
  final String nameWork;
  final String dateCreate;
  final double payroll;
  final String description;

  Work({
    required this.section,
    required this.nameWork,
    required this.dateCreate,
    required this.payroll,
    required this.description,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      section: json['section'],
      nameWork: json['name_work'],
      dateCreate: json['date_create'],
      payroll: double.parse(json['payroll'].toString()), // Convert to double
      description: json['description'],
    );
  }
}
