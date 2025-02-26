import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/myprofile.dart';
import 'package:hr/page/notification.dart';
import 'package:hr/page/payroll_manage.dart';
import 'package:hr/page/work_manage.dart';
import 'package:hr/widget/customListTIle.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/b2/1e/d9/b21ed98a5eb1d86a1dd633eb2ef59522.jpg',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "សួស្ដី, តារា វង្ស",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        child: Text('មើលព័ត៌មានរបស់អ្នក'),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => MyProfile(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("ការគ្រប់គ្រង", style: TextStyle(fontSize: 18)),
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
              Divider(indent: 67, height: 0, thickness: 0.6),
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
              Divider(indent: 67, height: 0, thickness: 0.6),
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
              Divider(indent: 67, height: 0, thickness: 0.6),
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
