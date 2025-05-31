import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_emp.dart';

class Member extends StatefulWidget {
  final String adminName;

  const Member({super.key, required this.adminName});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<QuerySnapshot> searchEmployees(String query) {
    final baseQuery = FirebaseFirestore.instance
        .collection('employees')
        .where('adminname', isEqualTo: widget.adminName);

    if (query.isEmpty) {
      return baseQuery.get();
    } else {
      return baseQuery
          .where('fullname', isGreaterThanOrEqualTo: query)
          .where('fullname', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black45,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('សមាជិកក្រុម', style: TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'ស្វែងរកសមាជិក'),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  controller: _searchController,
                ),
                const SizedBox(height: 10),
                FutureBuilder<QuerySnapshot>(
                  future: searchEmployees(_searchQuery),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
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
                      return const Center(
                        child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'),
                      );
                    } else {
                      final employees = snapshot.data?.docs ?? [];

                      if (employees.isEmpty) {
                        return Center(
                          child: Text(
                            _searchQuery.isEmpty
                                ? 'គ្មានសមាជិកក្រុមទេ'
                                : 'រកមិនឃើញ',
                          ),
                        );
                      }

                      return Column(
                        children: List.generate(employees.length, (index) {
                          final data =
                              employees[index].data() as Map<String, dynamic>;
                          final name = data['fullname'] ?? '...';
                          final position = data['workname'] ?? '...';

                          return ListTile(
                            contentPadding: const EdgeInsets.only(left: 0),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) =>
                                          DetailEmp(empId: employees[index].id),
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
                                  transitionDuration: Duration(
                                    milliseconds: 300,
                                  ),
                                ),
                              );
                            },
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(position),
                            trailing: const Icon(
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
    );
  }
}
