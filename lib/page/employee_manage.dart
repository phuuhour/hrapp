import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_emp.dart';
import 'package:hr/page/detail_emp.dart';
import 'package:intl/date_symbol_data_local.dart';

class EmployeeManage extends StatefulWidget {
  const EmployeeManage({super.key});

  @override
  State<EmployeeManage> createState() => _EmployeeManageState();
}

class _EmployeeManageState extends State<EmployeeManage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<QuerySnapshot> searchEmployees(String query) {
    if (query.isEmpty) {
      return FirebaseFirestore.instance.collection('employees').get();
    }
    return FirebaseFirestore.instance
        .collection('employees')
        .where('fullname', isGreaterThanOrEqualTo: query)
        .where('fullname', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
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
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 5,
              ),
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
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AddnewEmp(),
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.white,
                color: Colors.blue,
                onRefresh: () async {
                  setState(() {});
                },

                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
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
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'ស្វែងរកបុគ្គលិក',
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchEmployees(value);
                                _searchQuery = value;
                              });
                            },
                            controller: _searchController,
                          ),
                          SizedBox(height: 10),
                          FutureBuilder<QuerySnapshot>(
                            future: searchEmployees(_searchQuery),
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
                                  return Center(child: Text('រកមិនឃើញ'));
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
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                ) => DetailEmp(
                                                  empId:
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                          .id,
                                                ),
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
                                                position: animation.drive(
                                                  tween,
                                                ),
                                                child: child,
                                              );
                                            },
                                            transitionDuration: Duration(
                                              milliseconds: 300,
                                            ),
                                          ),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                          'assets/images/avatar.png',
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
            ),
          ],
        ),
      ),
    );
  }
}
