import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/myprofile.dart';
import 'package:hr/page/payroll_manage.dart';
import 'package:hr/page/work_manage.dart';
import 'package:hr/screen/loginScreen.dart';
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
                      'https://scontent.fpnh11-2.fna.fbcdn.net/v/t39.30808-6/459855964_1218722905839890_5711816434029203503_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHAYFN8L4rZL0ODqjswM_GCq2e-_u9bkfurZ77-71uR-6vzBHZwfS6n1AKUgs0hsbkrXPhkqwjf29G2_Fmfc8ui&_nc_ohc=m1aESqyAjAAQ7kNvgEMHe0c&_nc_oc=AdgcBFJzjDSE6gwcrURSnhVKVfsR_rH40BSn4fw6lxQ_qTHr2SgdLwjoo-GUDFFWeo4&_nc_zt=23&_nc_ht=scontent.fpnh11-2.fna&_nc_gid=AvMORiPn_cwj_RF3f31DIwn&oh=00_AYDu0D0ZRIiDTjhYJn0g2yHDuqmnzWczCcSAQGJwCH8VEQ&oe=67BB50F6',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "សួស្ដី, អាយដល",
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
                title: "គ្រប់គ្រងការបើកប្រាក់ខែ",
                subtitle: "ចំណាយប្រាក់ខែ",
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
