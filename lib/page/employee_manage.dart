import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_emp.dart';
import 'package:hr/page/detail_emp.dart';
import 'package:hr/widget/ListTIle.dart';
import 'package:intl/date_symbol_data_local.dart';

class EmployeeManage extends StatefulWidget {
  const EmployeeManage({super.key});

  @override
  State<EmployeeManage> createState() => _EmployeeManageState();
}

class _EmployeeManageState extends State<EmployeeManage> {
  Future<Map<String, int>> getEmpCount() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    final EmpCount = <String, int>{};

    for (var doc in snapshot.docs) {
      final workName =
          (doc.data() as Map<String, dynamic>)['empId'] ?? 'Unknown';
      EmpCount[workName] = (EmpCount[workName] ?? 0) + 1;
    }

    return EmpCount;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white, size: 20),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
        title: Text(
          'បញ្ជីឈ្មោះបុគ្គលិកទាំងអស់',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: Border.all(color: Colors.blue.withOpacity(0.5)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<Map<String, int>>(
                        future: getEmpCount(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomListTile(
                              icon: Boxicons.bxs_user_detail,
                              title: "បុគ្គលិកទាំងអស់",
                              subtitle: "សរុប៖ ..",
                              onPressed: () {},
                            );
                          } else {
                            final empCounts = snapshot.data ?? {};
                            final totalCount = empCounts.values.fold(
                              0,
                              (sum, count) => sum + count,
                            );
                            return CustomListTile(
                              icon: Boxicons.bxs_user_detail,
                              title: "បុគ្គលិកទាំងអស់",
                              subtitle: "សរុប៖ $totalCount",
                              onPressed: () {},
                            );
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddnewEmp(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'បន្ថែមបុគ្គលិកថ្មី',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                    child: Column(
                      children: [
                        FutureBuilder<QuerySnapshot>(
                          future:
                              FirebaseFirestore.instance
                                  .collection('employees')
                                  .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'),
                              );
                            } else {
                              final employees = snapshot.data?.docs ?? [];

                              if (employees.isEmpty) {
                                return Center(child: Text('មិនមានបុគ្គលិកទេ'));
                              }

                              return Column(
                                children: List.generate(employees.length, (
                                  index,
                                ) {
                                  final employee = employees[index];
                                  final data =
                                      employee.data() as Map<String, dynamic>;
                                  final name = data['fullname'] ?? '...';
                                  final position = data['workname'] ?? '...';

                                  return ListTile(
                                    contentPadding: EdgeInsets.only(left: 0),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder:
                                              (context) => DetailEmp(
                                                empId:
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                        .id,
                                              ),
                                        ),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        'assets/images/profile.png',
                                      ),
                                    ),
                                    title: Text(
                                      name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    subtitle: Text(position),
                                    trailing: Icon(
                                      Boxicons.bxs_chevron_right,
                                      color: Colors.grey,
                                    ),
                                  );
                                }),
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
