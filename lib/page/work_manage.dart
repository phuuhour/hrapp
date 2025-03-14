import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/apiService.dart';
import 'package:hr/model/work.dart';
import 'package:hr/page/addnew_work.dart';
import 'package:hr/page/detail_work.dart';
import 'package:hr/widget/customSearch.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class WorkManage extends StatefulWidget {
  const WorkManage({super.key});

  @override
  State<WorkManage> createState() => _WorkManageState();
}

class _WorkManageState extends State<WorkManage> {
  final ApiService apiService = ApiService();
  Future<List<Work>>? _worksFuture;

  @override
  void initState() {
    super.initState();
    _refreshData(); // Fetch data when the widget is first created
  }

  void _refreshData() {
    setState(() {
      _worksFuture = apiService.getWorks(); // Refresh the Future
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    var search = TextEditingController();
    onSearch(String value) {
      print(value);
    }

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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onTap: () async {
                            // Navigate to AddNewWork and wait for a result
                            final result = await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AddNewWork(),
                              ),
                            );

                            // If the result is true, refresh the data
                            if (result == true) {
                              _refreshData();
                            }
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
              SizedBox(height: 10),
              Customsearch(controller: search, onSearch: onSearch),
              SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<List<Work>>(
                  future: _worksFuture, // Use the Future stored in the state
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    }
                    final works = snapshot.data!;
                    return ListView.builder(
                      itemCount: works.length,
                      itemBuilder: (context, index) {
                        final work = works[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          shape: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                          title: Text(
                            work.section,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            work.nameWork,
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(
                            '\$${work.payroll.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder:
                                    (context) => DetailWork(
                                      work: work,
                                    ), // Pass the Work object
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
