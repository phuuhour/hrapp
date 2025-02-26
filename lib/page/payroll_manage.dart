import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/formadjustsalary.dart';
import 'package:hr/page/payrollbyemp.dart';
import 'package:hr/page/payrollbywork.dart';
import 'package:hr/widget/customListTIle.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class PayrollManage extends StatelessWidget {
  const PayrollManage({super.key});

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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('ចំណាយលើប្រាក់ខែ', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(18),
                  height: MediaQuery.of(context).size.height * 0.25,
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
                                  Boxicons.bxs_dollar_circle,
                                  size: 35,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ប្រាក់ប្រចាំខែ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
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
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ទឹកប្រាក់សរុបៈ \$8500',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'ថ្ងៃបើកប្រាក់ខែៈ $currentmonth',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'ថ្ងៃបើកខែបន្ទាប់ៈ $nextmonth',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          HugeIcons.strokeRoundedDownload04,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomListTile(
                  icon: Boxicons.bxs_user,
                  title: 'ប្រាក់ខែសរុប (បុគ្គលិក)',
                  subtitle: 'សរុបប្រាក់ខែទាំងអស់',
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Payrollbyemp()),
                    );
                  },
                ),
                CustomListTile(
                  icon: Boxicons.bxs_shopping_bag,
                  title: 'ប្រាក់ខែសរុប (ការងារ)',
                  subtitle: 'សរុបប្រាក់ខែទាំងអស់',
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => PayrollbyWork()),
                    );
                  },
                ),
                CustomListTile(
                  icon: Boxicons.bxs_hand_up,
                  title: 'ស្នើរសុំបន្ថែមទឹកប្រាក់',
                  subtitle: 'ទម្រង់ស្នើរសុំបន្ថែមទឹកប្រាក់',
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => AdjustSalary()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
