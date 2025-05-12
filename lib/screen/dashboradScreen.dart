// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/payroll_manage.dart';
import 'package:hr/page/search.dart';
import 'package:hr/page/work_manage.dart';
import 'package:hr/widget/ListTIle.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'កម្មវិធីគ្រប់គ្រងបុគ្គលិក',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              DateFormat(
                'ថ្ងៃEEE ទីdd ខែMMM ឆ្នាំyyyy',
                'km',
              ).format(DateTime.now()),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => Searchpage()),
          );
        },
        elevation: 0,
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: Icon(Icons.search, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                shape: Border.symmetric(
                  vertical: BorderSide(color: Colors.blue, width: 3),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: CustomListTile(
                    icon: Boxicons.bxs_user_detail,

                    title: "បុគ្គលិកទាំងអស់",
                    subtitle: "បញ្ជីឈ្មោះបុគ្គលិក",

                    onPressed: () {
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
              Card(
                shape: Border.symmetric(
                  vertical: BorderSide(color: Colors.lightGreen, width: 3),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: CustomListTile(
                    icon: Boxicons.bxs_briefcase,
                    color: Colors.green,
                    title: "ការងារទាំងអស់",
                    subtitle: "បញ្ជីការងារ",
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => WorkManage()),
                      );
                    },
                  ),
                ),
              ),

              Card(
                shape: Border.symmetric(
                  vertical: BorderSide(color: Colors.orangeAccent, width: 3),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: CustomListTile(
                    icon: Boxicons.bxs_dollar_circle,
                    color: Colors.orangeAccent,
                    title: "ប្រាក់ប្រចាំខែ",
                    subtitle: "មើលចំនួនប្រាក់ខែ",
                    onPressed: () {
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
              Card(
                shape: Border.symmetric(
                  vertical: BorderSide(color: Colors.purple, width: 3),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: CustomListTile(
                    icon: Boxicons.bxs_user_plus,
                    color: Colors.purple,
                    title: "គណនីបុគ្គលិក",
                    subtitle: "បង្កើតគណនីបុគ្គលិកថ្មី",
                    onPressed: () {
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
