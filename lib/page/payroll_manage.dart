// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/empdata.dart';
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
      backgroundColor: Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black45, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('បញ្ជីប្រាក់ខែ', style: TextStyle(fontSize: 16)),
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
                            Image(
                              image: AssetImage('assets/images/salary.PNG'),
                              height: 50,
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  final baseSal = data['baseSal'] ?? '...';

                                  return ListTile(
                                    contentPadding: EdgeInsets.only(left: 0),

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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
