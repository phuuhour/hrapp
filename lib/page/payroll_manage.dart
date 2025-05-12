// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/empdata.dart';
import 'package:hr/page/detail_emp.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class PayrollManage extends StatefulWidget {
  const PayrollManage({super.key});

  @override
  State<PayrollManage> createState() => _PayrollManageState();
}

class _PayrollManageState extends State<PayrollManage> {
  Future<double> fetchTotalSalary() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    double totalSalary = 0.0;

    for (var doc in snapshot.docs) {
      final empData = EmpData.fromMap(doc.data() as Map<String, dynamic>);
      totalSalary += double.tryParse(empData.baseSal) ?? 0.0;
    }

    return totalSalary;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);

    DateTime now = DateTime.now();

    DateTime nextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfCurrentMonth = DateTime(now.year, now.month + 1, 0);

    DateTime lastDayOfNextMonth = DateTime(
      nextMonth.year,
      nextMonth.month + 1,
      0,
    );

    String nextmonth = DateFormat(
      'dd MMM yyyy',
      'km',
    ).format(lastDayOfNextMonth);
    String currentmonth = DateFormat(
      'dd MMM yyyy',
      'km',
    ).format(lastDayOfCurrentMonth);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'បញ្ជីប្រាក់ខែសរុប',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white, size: 20),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      // ignore: deprecated_member_use
                      color: Colors.orangeAccent.withOpacity(0.5),
                    ),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.orangeAccent,
                                  child: Icon(
                                    Boxicons.bxs_dollar_circle,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ទឹកប្រាក់ប្រចាំខែ',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        'ថ្ងៃនេះៈ dd MMM yyyy',
                                        'km',
                                      ).format(DateTime.now()),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                FutureBuilder<double>(
                                  future: fetchTotalSalary(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text(
                                        'ទឹកប្រាក់សរុបៈ ...',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        'ទឹកប្រាក់សរុបៈ មានបញ្ហា',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        'ទឹកប្រាក់សរុបៈ \$${snapshot.data?.toStringAsFixed(2) ?? '0.00'}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ថ្ងៃបើកប្រាក់ខែៈ $currentmonth',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ថ្ងៃបើកខែបន្ទាប់ៈ $nextmonth',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
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
                                final baseSal = data['baseSal'] ?? '...';

                                return ListTile(
                                  contentPadding: EdgeInsets.only(left: 0),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder:
                                            (context) => DetailEmp(
                                              empId:
                                                  snapshot.data!.docs[index].id,
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
                                  subtitle: Text('\$' + baseSal),
                                  trailing: Text(
                                    data['workname'] ?? '...',
                                    style: TextStyle(fontSize: 16),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
