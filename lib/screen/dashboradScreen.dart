// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/adminaccount.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/payroll_manage.dart';
import 'package:hr/page/profileDetail.dart';
import 'package:hr/page/search.dart';
import 'package:hr/page/work_manage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  final AdminAccount admin;

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
                    subtitle: Text('បុគ្គលិកទាំងអស់'),
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
                    subtitle: Text('ការងារទាំងអស់'),
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
                      image: AssetImage('assets/images/search.png'),
                      height: 60,
                    ),
                    title: Text('ស្វែងរក'),
                    subtitle: Text('បុគ្គលិក និង ការងារ'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => Searchpage()),
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
