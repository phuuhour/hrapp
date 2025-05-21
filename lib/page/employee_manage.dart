import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_emp.dart';
import 'package:hr/page/createaccount.dart';
import 'package:hr/page/detail_emp.dart';
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

    final empCount = <String, int>{};

    for (var doc in snapshot.docs) {
      final workName =
          (doc.data() as Map<String, dynamic>)['empId'] ?? 'Unknown';
      empCount[workName] = (empCount[workName] ?? 0) + 1;
    }

    return empCount;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      backgroundColor: Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black45, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('បុគ្គលិកទាំងអស់', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => AddnewEmp()),
                        );
                      },
                      title: Text(
                        'បន្ថែមបុគ្គលិកថ្មី',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(
                        Boxicons.bxs_user_plus,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => CreateAcc()),
                        );
                      },
                      title: Text(
                        'បង្កើតគណនីថ្មី',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.add_circle_sharp,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        FutureBuilder<Map<String, int>>(
                          future: getEmpCount(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                contentPadding: EdgeInsets.only(left: 0),
                                title: Text('បុគ្គលិកសរុប'),
                                subtitle: Text('...'),
                                onTap: () {},
                              );
                            } else {
                              final empCounts = snapshot.data ?? {};
                              final totalCount = empCounts.values.fold(
                                0,
                                // ignore: avoid_types_as_parameter_names
                                (sum, count) => sum + count,
                              );
                              return ListTile(
                                title: Text('បុគ្គលិកសរុប'),
                                contentPadding: EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Boxicons.bx_refresh,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                ),
                                subtitle: Text(
                                  '$totalCount នាក់',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => EmployeeManage(),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        Divider(),
                        FutureBuilder<QuerySnapshot>(
                          future:
                              FirebaseFirestore.instance
                                  .collection('employees')
                                  .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 5,
                                  child: LinearProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue,
                                    ),
                                    // strokeWidth: 2.0,
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
