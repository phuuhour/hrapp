// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HR/model/adminaccount.dart';
import 'package:HR/page/employee_manage.dart';
import 'package:HR/page/payroll_manage.dart';
import 'package:HR/page/profileDetail.dart';
import 'package:HR/page/work_manage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  final AdminAccount admin;

  const DashboardScreen({super.key, required this.admin});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Function to get employee count
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

  // Function to get work name count
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
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                          ProfileDetail(admin: widget.admin),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    widget.admin.imgUrl.isNotEmpty
                        ? NetworkImage(widget.admin.imgUrl)
                        : AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                onBackgroundImageError: (_, __) {},
              ),
            ),
          ),
        ],

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "សូមស្វាគមន៍ ${widget.admin.fullname}",
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
          // Main content of the dashboard
          child: RefreshIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.white,
            color: Colors.blue,
            onRefresh: () async {
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      EmployeeManage(),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
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
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      WorkManage(),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
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
                          image: AssetImage('assets/images/salary.PNG'),
                          height: 60,
                        ),
                        title: Text('ប្រាក់ខែ'),
                        subtitle: Text('ប្រាក់ខែសរុបបុគ្គលិក'),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PayrollManage(),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
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
        ),
      ),
    );
  }
}
