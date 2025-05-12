// ignore_for_file: deprecated_member_use, avoid_types_as_parameter_names

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/addnew_work.dart';
import 'package:hr/page/list_work.dart';
import 'package:hr/widget/ListTIle.dart';
import 'package:intl/date_symbol_data_local.dart';

class WorkManage extends StatefulWidget {
  const WorkManage({super.key});

  @override
  State<WorkManage> createState() => _WorkManageState();
}

Future<Map<String, int>> getWorkNameCount() async {
  final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('works').get();

  final workNameCounts = <String, int>{};

  for (var doc in snapshot.docs) {
    final workName =
        (doc.data() as Map<String, dynamic>)['workName'] ?? 'Unknown';
    workNameCounts[workName] = (workNameCounts[workName] ?? 0) + 1;
  }

  return workNameCounts;
}

class _WorkManageState extends State<WorkManage> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ប្រភេទនិងបញ្ជីឈ្មោះការងារទាំងអស់',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white, size: 20),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: Border.all(color: Colors.green.withOpacity(0.5)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<Map<String, int>>(
                        future: getWorkNameCount(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomListTile(
                              icon: Boxicons.bxs_briefcase,
                              color: Colors.green,
                              title: "ការងារទាំងអស់",
                              subtitle: "សរុប៖ ..",
                              onPressed: () {},
                            );
                          } else {
                            final sectionCounts = snapshot.data ?? {};
                            final totalCount = sectionCounts.values.fold(
                              0,

                              (sum, count) => sum + count,
                            );
                            return Column(
                              children: [
                                CustomListTile(
                                  icon: Boxicons.bxs_briefcase,
                                  color: Colors.green,
                                  title: "ការងារទាំងអស់",
                                  subtitle: "សរុប៖ $totalCount",
                                  onPressed: () {},
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddNewWork(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'បន្ថែមការងារថ្មី',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                    child: Column(
                      children: [
                        FutureBuilder<QuerySnapshot>(
                          future:
                              FirebaseFirestore.instance
                                  .collection('works')
                                  .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  padding: EdgeInsets.only(top: 200),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'),
                              );
                            } else {
                              final works = snapshot.data?.docs ?? [];
                              final sectionMap = <String, List<String>>{};

                              for (var work in works) {
                                final data =
                                    work.data() as Map<String, dynamic>;
                                final section = data['section'] ?? 'Unknown';
                                final workName = data['workName'] ?? 'Unknown';

                                if (!sectionMap.containsKey(section)) {
                                  sectionMap[section] = [];
                                }
                                sectionMap[section]!.add(workName);
                              }

                              // Filter out sections with no works
                              final filteredSections =
                                  sectionMap.entries
                                      .where((entry) => entry.value.isNotEmpty)
                                      .toList();

                              if (filteredSections.isEmpty) {
                                return Center(child: Text('មិនមានការងារទេ'));
                              }

                              return Column(
                                children:
                                    filteredSections.map((entry) {
                                      final section = entry.key;
                                      final workNames = entry.value;
                                      return ListTile(
                                        contentPadding: EdgeInsets.only(
                                          left: 0,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder:
                                                  (context) => ListWork(
                                                    sectionTitle: section,
                                                  ),
                                            ),
                                          );
                                        },
                                        title: Text(section),
                                        subtitle: Text(
                                          'ការងារសរុប៖ ${workNames.length}',
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                          color: Colors.black45,
                                        ),
                                      );
                                    }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
