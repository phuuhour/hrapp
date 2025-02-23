import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/work_manage.dart';
import 'package:hr/screen/loginScreen.dart';
import 'package:hr/widget/customButton.dart' as btn;
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/widget/showdialog.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

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
                        "អាយដល",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text('HR'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("ព័ត៌មានបុគ្គលិក", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),

              CustomListTile(
                icon: Boxicons.bxs_phone,
                title: "លេខទូរស័ព្ទ",
                subtitle: "014789632",
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
                subtitle: "HR, CEO",
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
                title: "ប្រាក់ខែ",
                subtitle: "\$1200",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_calendar,
                title: "ថ្ងៃខែចូលធ្វើការ",
                subtitle: "12-02-2021",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
