import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HR/model/section.dart';
import 'package:HR/page/list_work.dart';
import 'package:HR/widget/Button.dart';
import 'package:HR/widget/TextField.dart';

class ListSection extends StatefulWidget {
  const ListSection({super.key});

  @override
  State<ListSection> createState() => _ListSectionState();
}

class _ListSectionState extends State<ListSection> {
  bool isLoading = false;
  bool isAddingSection = false;
  final TextEditingController _sectionController = TextEditingController();

  Future<Map<String, int>> getSectionCount() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('sections').get();
    final sectionCounts = <String, int>{};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final section = data['sectionName'] ?? 'Unknown';
      sectionCounts[section] = (sectionCounts[section] ?? 0) + 1;
    }
    return sectionCounts;
  }

  Future<List<String>> getAllSections() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('sections').get();
    return snapshot.docs
        .map((doc) => doc.data()['sectionName'] as String? ?? 'Unknown')
        .toList();
  }

  Future<void> addSection(String sectionName) async {
    try {
      await FirebaseFirestore.instance.collection('sections').add({
        'sectionName': sectionName,
      });
    } catch (e) {
      print('Error adding section: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black45,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('ផ្នែកការងារទាំងអស់', style: TextStyle(fontSize: 16)),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                    'បន្ថែមផ្នែកការងារថ្មី',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  content: SizedBox(
                                    height: 145,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          label: 'ប្រភេទការងារ',
                                          icon: const Icon(Icons.abc),
                                          hint: 'ផ្នែកការងារថ្មី',
                                          keyboardType: TextInputType.text,
                                          lendingIcon: false,
                                          controller: _sectionController,
                                        ),
                                        const SizedBox(height: 30),
                                        CustomButton(
                                          color: Colors.blue,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 45, // Set button height
                                          isLoading: isAddingSection,
                                          text: 'បញ្ជូន',
                                          onPressed: () async {
                                            setState(() {
                                              isAddingSection = true;
                                            });
                                            final sectionName =
                                                _sectionController.text.trim();

                                            if (sectionName.isEmpty) {
                                              setState(() {
                                                isAddingSection = false;
                                              });
                                              return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                      'សូមបញ្ចូលឈ្មោះផ្នែក',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                        },
                                                        child: const Text(
                                                          'យល់ព្រម',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }

                                            if (sectionName.startsWith(
                                              RegExp(r'^[0-9\u17E0-\u17E9]'),
                                            )) {
                                              setState(() {
                                                isAddingSection = false;
                                              });
                                              return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                      'មិនអាចចាប់ផ្តើមដោយលេខទេ',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                        },
                                                        child: const Text(
                                                          'យល់ព្រម',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }

                                            final isSectionExists =
                                                await FirebaseFirestore.instance
                                                    .collection('sections')
                                                    .where(
                                                      'sectionName',
                                                      isEqualTo: sectionName,
                                                    )
                                                    .get()
                                                    .then(
                                                      (value) =>
                                                          value.docs.isNotEmpty,
                                                    );

                                            if (isSectionExists) {
                                              setState(() {
                                                isAddingSection = false;
                                              });
                                              return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                      'ផ្នែក "$sectionName" នេះមានហើយ',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                        },
                                                        child: const Text(
                                                          'យល់ព្រម',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }

                                            await FirebaseFirestore.instance
                                                .collection('sections')
                                                .add(
                                                  SectionData(
                                                    sectionName: sectionName,
                                                  ).toMap(),
                                                );
                                            setState(() {
                                              isAddingSection = false;
                                              _sectionController.clear();
                                            });
                                            if (mounted) {
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'ផ្នែកត្រូវបានបន្ថែមដោយជោគជ័យ!',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    SizedBox(
                                      height: 40,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'លុប',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      title: const Text(
                        'បន្ថែមផ្នែកការងារថ្មី',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(
                        Boxicons.bxs_plus_circle,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        FutureBuilder<Map<String, int>>(
                          future: getSectionCount(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ListTile(
                                contentPadding: EdgeInsets.only(left: 0),
                                title: Text('បញ្ជីឈ្មោះផ្នែកទាំងអស់'),
                                subtitle: Text('កំពុងទាញយក...'),
                              );
                            } else {
                              final sectionCounts = snapshot.data ?? {};
                              final totalCount = sectionCounts.values.fold(
                                0,
                                (sum, count) => sum + count,
                              );
                              return ListTile(
                                title: const Text('បញ្ជីឈ្មោះផ្នែកទាំងអស់'),
                                contentPadding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Boxicons.bx_refresh,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                ),
                                subtitle: Text(
                                  '$totalCount ផ្នែក',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                onTap: () {},
                              );
                            }
                          },
                        ),
                        const Divider(),
                        FutureBuilder<QuerySnapshot>(
                          future:
                              FirebaseFirestore.instance
                                  .collection('works')
                                  .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 5,
                                  child: LinearProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue,
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'),
                              );
                            } else {
                              final works = snapshot.data?.docs ?? [];
                              final sectionWorkMap = <String, List<String>>{};
                              final allSections = <String>{};

                              // Populate sections from 'sections' collection
                              return FutureBuilder<QuerySnapshot>(
                                future:
                                    FirebaseFirestore.instance
                                        .collection('sections')
                                        .get(),
                                builder: (context, sectionSnapshot) {
                                  if (sectionSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                      width: 50,
                                      height: 5,
                                      child: const Center(
                                        child: LinearProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.blue,
                                              ),
                                        ),
                                      ),
                                    ); // Or some other loading indicator
                                  } else if (sectionSnapshot.hasError) {
                                    return const Center(
                                      child: Text('Failed to load sections'),
                                    );
                                  } else {
                                    final sectionsData =
                                        sectionSnapshot.data?.docs ?? [];
                                    for (var sectionDoc in sectionsData) {
                                      final sectionData =
                                          sectionDoc.data()
                                              as Map<String, dynamic>?;
                                      final sectionName =
                                          sectionData?['sectionName']
                                              as String? ??
                                          'Unknown';
                                      allSections.add(sectionName);
                                      sectionWorkMap.putIfAbsent(
                                        sectionName,
                                        () => [],
                                      );
                                    }

                                    // Populate work names per section
                                    for (var work in works) {
                                      final data =
                                          work.data() as Map<String, dynamic>;
                                      final section =
                                          data['section'] as String? ??
                                          'Unknown';
                                      final workName =
                                          data['workName'] as String? ??
                                          'Unknown';
                                      if (sectionWorkMap.containsKey(section)) {
                                        sectionWorkMap[section]!.add(workName);
                                      } else {
                                        // Handle works with sections not in the sections collection
                                        sectionWorkMap[section] = [workName];
                                        allSections.add(section);
                                      }
                                    }

                                    final sectionListTiles =
                                        allSections.map((section) {
                                          final workNames =
                                              sectionWorkMap[section] ?? [];
                                          return ListTile(
                                            contentPadding:
                                                const EdgeInsets.only(left: 0),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) => ListWork(
                                                        sectionTitle: section,
                                                      ),
                                                  transitionsBuilder: (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child,
                                                  ) {
                                                    const begin = Offset(
                                                      1.0,
                                                      0.0,
                                                    );
                                                    const end = Offset.zero;
                                                    const curve =
                                                        Curves.easeInOut;

                                                    var tween = Tween(
                                                      begin: begin,
                                                      end: end,
                                                    ).chain(
                                                      CurveTween(curve: curve),
                                                    );
                                                    return SlideTransition(
                                                      position: animation.drive(
                                                        tween,
                                                      ),
                                                      child: child,
                                                    );
                                                  },
                                                  transitionDuration:
                                                      const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                ),
                                              );
                                            },
                                            title: Text(section),
                                            subtitle: Text(
                                              '${workNames.length}',
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                              color: Colors.black45,
                                            ),
                                          );
                                        }).toList();

                                    if (sectionListTiles.isEmpty) {
                                      return const Center(
                                        child: Text('មិនមានផ្នែកទេ'),
                                      );
                                    }

                                    return Column(children: sectionListTiles);
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
