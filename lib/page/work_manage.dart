import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_work.dart';
import 'package:hr/page/detail_work.dart';
import 'package:hr/page/formadjustsalary.dart';
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/widget/customTextField.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class WorkManage extends StatelessWidget {
  const WorkManage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('ប្រភេទការងារ និងមុខតំណែង', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                                  Boxicons.bxs_shopping_bag,
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
                                    'ការងារនិងតួនាទី',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    'សរុបៈ 5មុខតំណែង',
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
                                  builder: (context) => AddNewWork(),
                                ),
                              );
                            },
                            child: Text(
                              'បន្ថែមការងារថ្មី',
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
                SizedBox(height: 20),
                CustomListTile(
                  icon: Boxicons.bx_network_chart,
                  title: 'Network Engineer',
                  subtitle: '10-02-2017',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:
                          (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.942,
                            child: DetailWork(),
                          ),
                    );
                  },
                ),
                CustomListTile(
                  icon: Boxicons.bxl_javascript,
                  title: 'Javascript Developer',
                  subtitle: '11-05-2012',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
