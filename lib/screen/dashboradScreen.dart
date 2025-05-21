// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/adminaccount.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/payroll_manage.dart';
import 'package:hr/page/profileDetail.dart';
import 'package:hr/page/work_manage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  final AdminAccount admin;

  Future<Map<String, int>> getEmpCount() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    final empCount = <String, int>{};

    for (var doc in snapshot.docs) {
      final workName =
          (doc.data() as Map<String, dynamic>)['empId'] ?? 'Unknown';
      empCount[workName] = (empCount[workName] ?? 0) + 1;
    }

    return empCount;
  }

  Future<Map<String, int>> getWorkNameCount() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('works').get();

    final workNameCounts = <String, int>{};

    for (var doc in snapshot.docs) {
      final workName =
          (doc.data() as Map<String, dynamic>)['workName'] ?? 'Unknown';
      workNameCounts[workName] = (workNameCounts[workName] ?? 0) + 1;
    }

    return workNameCounts;
  }

  const DashboardScreen({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      backgroundColor: Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ProfileDetail(admin: admin),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "សូមស្វាគមន៍ ${admin.fullname}",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              DateFormat('EEEE, d MMMM yyyy', 'km').format(DateTime.now()),
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/employee.png'),
                      height: 60,
                    ),
                    title: Text('បុគ្គលិក'),
                    subtitle: FutureBuilder<Map<String, int>>(
                      future: getEmpCount(),
                      key: const ValueKey('emp_count'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'កំពុងទាញយក...',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                          );
                        } else {
                          final empCounts = snapshot.data ?? {};
                          final totalCount = empCounts.values.fold(
                            0,
                            (sum, count) => sum + count,
                          );
                          return Text(
                            'សរុបចំនួន៖ $totalCount នាក់',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          );
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EmployeeManage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/work.PNG'),
                      height: 60,
                    ),
                    title: Text('ការងារ'),
                    subtitle: FutureBuilder<Map<String, int>>(
                      future: getWorkNameCount(),
                      key: const ValueKey('work_count'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'កំពុងទាញយក...',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                          );
                        } else {
                          final sectionCounts = snapshot.data ?? {};
                          final totalCount = sectionCounts.values.fold(
                            0,
                            (sum, count) => sum + count,
                          );
                          return Text(
                            'សរុបចំនួន៖ $totalCount ការងារ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          );
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => WorkManage()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/salary.PNG'),
                      height: 60,
                    ),
                    title: Text('ប្រាក់ខែ'),
                    subtitle: Text('ប្រាក់ខែសរុប'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PayrollManage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
