import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/employee_manage.dart';
import 'package:hr/page/work_manage.dart';
import 'package:hr/screen/loginScreen.dart';
import 'package:hr/widget/customListTIle.dart';

class DetailWork extends StatelessWidget {
  const DetailWork({super.key});

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
                      'https://orangematter.solarwinds.com/wp-content/uploads/2018/05/iStock-500923676-1024x717.jpg',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Network Engineer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      GestureDetector(
                        child: Text('IT'),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("ព័ត៌មានការងារ", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),

              CustomListTile(
                icon: Boxicons.bxs_detail,
                title: "ឈ្មោះការងារ",
                subtitle: "Network Engineer",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bx_list_ul,
                title: "ប្រភេទការងារ",
                subtitle: "ពេញម៉ោង",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_dollar_circle,
                title: "ប្រាក់បៀវត្សរ៍",
                subtitle: "\$5200",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_calendar,
                title: "ថ្ងៃខែចាប់ផ្ដើម",
                subtitle: "12-02-2011",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
