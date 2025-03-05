import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_emp.dart';
import 'package:hr/page/detail_emp.dart';
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/widget/customTextField.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class EmployeeManage extends StatelessWidget {
  const EmployeeManage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('គ្រប់គ្រងបុគ្គលិកទាំងអស់', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(18),
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
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
                              backgroundColor: Colors.white,
                              child: Icon(
                                Boxicons.bxs_user_detail,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'គ្រប់គ្រងបុគ្គលិក',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'បុគ្គលិកសរុបៈ 10 នាក់',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat(
                            'dd MMM yyyy',
                            'km',
                          ).format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AddnewEmp(),
                              ),
                            );
                          },
                          child: Text(
                            'បន្ថែមបុគ្គលិកថ្មី',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomTextField(
                label: '',
                hint: 'ស្វែងរក...',
                icon: HugeIcons.strokeRoundedSearch02,
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 0),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DetailEmp(),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://scontent.fpnh11-1.fna.fbcdn.net/v/t39.30808-6/475308868_1150454489757657_4675051414966855150_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGoqGxxuSOm7JRBHicgzV2iJ5dpbjLjgoAnl2luMuOCgCFV8yLuLbqVMINGL6ZipNmoo9b2c_aGV3EZIkBgOjF-&_nc_ohc=8A7RoeGhDaMQ7kNvgE6_Rur&_nc_oc=AdimCXcR1fKdlVz_09d1sGx-ZMXjYtjuXjxNNJshYrag3vQbXNmzZ2Y49uMKfyJ3FyU&_nc_zt=23&_nc_ht=scontent.fpnh11-1.fna&_nc_gid=A5sq0U8Z2oy22w587Gyf3d0&oh=00_AYAcM_b3qf8PvfSwe77Zar2XcTswXjmOVvUGWeo4Hm0ZpA&oe=67CC8FE4',
                          ),
                        ),
                        title: Text("រិន សុដា", style: TextStyle(fontSize: 16)),
                        subtitle: Text('Network Engineer'),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 0),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DetailEmp(),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://scontent.fpnh11-1.fna.fbcdn.net/v/t39.30808-6/475308868_1150454489757657_4675051414966855150_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGoqGxxuSOm7JRBHicgzV2iJ5dpbjLjgoAnl2luMuOCgCFV8yLuLbqVMINGL6ZipNmoo9b2c_aGV3EZIkBgOjF-&_nc_ohc=8A7RoeGhDaMQ7kNvgE6_Rur&_nc_oc=AdimCXcR1fKdlVz_09d1sGx-ZMXjYtjuXjxNNJshYrag3vQbXNmzZ2Y49uMKfyJ3FyU&_nc_zt=23&_nc_ht=scontent.fpnh11-1.fna&_nc_gid=A5sq0U8Z2oy22w587Gyf3d0&oh=00_AYAcM_b3qf8PvfSwe77Zar2XcTswXjmOVvUGWeo4Hm0ZpA&oe=67CC8FE4',
                          ),
                        ),
                        title: Text("រិន សុដា", style: TextStyle(fontSize: 16)),
                        subtitle: Text('Network Engineer'),
                      ),
                    ],
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
