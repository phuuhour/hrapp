import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/formadjustsalary.dart';
import 'package:hr/page/payrollbyemp.dart';
import 'package:hr/page/payrollbywork.dart';
import 'package:hr/widget/ListTIle.dart';
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
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'បញ្ជីប្រាក់ខែសរុប',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      // ignore: deprecated_member_use
                      color: Colors.orangeAccent.withOpacity(0.5),
                    ),
                  ),
                  color: Colors.white,
                  child: Padding(
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
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.orangeAccent,
                                  child: Icon(
                                    Boxicons.bxs_dollar_circle,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                Text(
                                  'ទឹកប្រាក់សរុបៈ NULL',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
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
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.downloading,
                            size: 40,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CustomListTile(
                        color: Colors.orangeAccent,
                        icon: Boxicons.bxs_user,
                        title: 'ប្រាក់សរុប (បុគ្គលិក)',
                        subtitle: 'ប្រាក់សរុបបុគ្គលិកទាំងអស់',
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Payrollbyemp(),
                            ),
                          );
                        },
                      ),
                      CustomListTile(
                        color: Colors.orangeAccent,
                        icon: Boxicons.bxs_shopping_bag,
                        title: 'ប្រាក់សរុប (ការងារ)',
                        subtitle: 'ប្រាក់សរុបតាមការងារ',
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => PayrollbyWork(),
                            ),
                          );
                        },
                      ),
                      CustomListTile(
                        color: Colors.orangeAccent,
                        icon: Boxicons.bxs_hand_up,
                        title: 'ស្នើរសុំបន្ថែមប្រាក់ខែ',
                        subtitle: 'ទម្រង់ស្នើរសុំបន្ថែមទឹកប្រាក់',
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AdjustSalary(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
