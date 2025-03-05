import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/notification.dart';
import 'package:hr/page/payroll_manage.dart';
import 'package:hr/page/work_manage.dart';
import 'package:hr/widget/customListTIle.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('គ្រប់គ្រងបុគ្គលិកនិងការងារ'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              CustomListTile(
                icon: Boxicons.bxs_user_detail,
                title: "គ្រប់គ្រងបុគ្គលិកទាំងអស់",
                subtitle: "បញ្ជីឈ្មោះបុគ្គលិក",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => EmployeeManage()),
                  );
                },
              ),
              CustomListTile(
                icon: Boxicons.bxs_shopping_bag,
                title: "ប្រភេទការងារ និងមុខតំណែង",
                subtitle: "បញ្ជីឈ្មោះការងារនិងតំណែង",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => WorkManage()),
                  );
                },
              ),
              CustomListTile(
                icon: Boxicons.bxs_dollar_circle,
                title: "ចំណាយលើប្រាក់ខែ",
                subtitle: "មើលចំនួនប្រាក់ខែ",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => PayrollManage()),
                  );
                },
              ),
              CustomListTile(
                icon: Boxicons.bxs_bell,
                title: "សារជូនដំណឹង",
                subtitle: "ព័ត៌មាន",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
