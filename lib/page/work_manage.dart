// ignore_for_file: deprecated_member_use, avoid_types_as_parameter_names

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_emp.dart';
import 'package:hr/page/addnew_work.dart';
import 'package:hr/page/detail_work.dart';
import 'package:hr/page/list_section.dart';
import 'package:intl/date_symbol_data_local.dart';

class WorkManage extends StatefulWidget {
  const WorkManage({super.key});

  @override
  State<WorkManage> createState() => _WorkManageState();
}

class _WorkManageState extends State<WorkManage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<QuerySnapshot> searchEmployees(String query) {
    if (query.isEmpty) {
      return FirebaseFirestore.instance.collection('works').get();
    }
    return FirebaseFirestore.instance
        .collection('works')
        .where('workName', isGreaterThanOrEqualTo: query)
        .where('workName', isLessThanOrEqualTo: '$query\uf8ff')
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
        title: Text(
          'ផ្នែក និងបញ្ជីឈ្មោះការងារ',
          style: TextStyle(fontSize: 16),
        ),
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
                                    ListSection(),
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
                        'ផ្នែកនៃការងារ',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.group_work_sharp,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AddNewWork(),
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
                        'បន្ថែមការងារថ្មី',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(
                        Boxicons.bxs_briefcase,
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
                      vertical: 5,
                      horizontal: 10,
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
                              hintText: 'ស្វែងរកការងារ',
                            ),
                            onChanged: (value) {
                              setState(() {
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
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'),
                                );
                              } else {
                                final works = snapshot.data?.docs ?? [];

                                if (works.isEmpty) {
                                  return Center(child: Text('រកមិនឃើញ'));
                                }

                                return Column(
                                  children: List.generate(works.length, (
                                    index,
                                  ) {
                                    final work = works[index];
                                    final data =
                                        work.data() as Map<String, dynamic>;
                                    final workName = data['workName'] ?? '...';
                                    final branch = data['branch'] ?? '...';

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
                                                ) => DetailWork(
                                                  workId: work.id,
                                                  workData: data,
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

                                      title: Text(
                                        workName,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      subtitle: Text(branch),
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
