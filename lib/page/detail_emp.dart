// ignore_for_file: use_build_context_synchronously

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr/model/empdata.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailEmp extends StatefulWidget {
  final String empId;

  const DetailEmp({super.key, required this.empId});

  @override
  State<DetailEmp> createState() => _DetailEmpState();
}

class _DetailEmpState extends State<DetailEmp> {
  Future<EmpData?> fetchEmployeeData() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(widget.empId)
              .get();
      if (doc.exists && doc.data() != null) {
        return EmpData.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching employee data: $e');
      return null;
    }
  }

  Future<void> deleteEmpById({
    required String empId,
    required BuildContext context,
    required VoidCallback onSuccess, // Callback after successful deletion
  }) async {
    try {
      // Check if employee exists
      final doc =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(empId)
              .get();

      if (!doc.exists) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('បុគ្គលិកមិនត្រូវបានរកឃើញទេ!'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Delete the employee
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(empId)
          .delete();

      // Show success message (green background)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('លុបបានជោគជ័យ!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
        onSuccess();
      }
    } catch (e) {
      debugPrint('Error deleting employee: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('កំហុស៖ ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      backgroundColor: Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black45, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('ព័ត៌មានបុគ្គលិក', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'លុបបុគ្គលិក',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    content: Text('តើអ្នកប្រាកដថាចង់លុបបុគ្គលិកនេះមែនទេ?'),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'មិនធ្វើ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await deleteEmpById(
                            empId: widget.empId,
                            context: context,
                            onSuccess: () {},
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'លុប',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Boxicons.bxs_trash, color: Colors.red[400], size: 20),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        FutureBuilder<EmpData?>(
                          future: fetchEmployeeData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  height: 35,
                                  width: 50,
                                  child: Center(
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('កំហុស៖ ${snapshot.error}'),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: Text('មិនមានទិន្នន័យបុគ្គលិក'),
                              );
                            }

                            final empData = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'ព័ត៌មានបុគ្គលិក',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: const Text("លេខសម្គាល់"),
                                      trailing: Text(
                                        empData.empId,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text("ឈ្មោះពេញ"),
                                      trailing: Text(
                                        empData.fullname,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("ភេទ"),
                                      trailing: Text(
                                        empData.gender,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("ថ្ងៃខែឆ្នាំកំណើត"),
                                      trailing: Text(
                                        empData.dob != null
                                            ? DateFormat(
                                              'dd MMM yyyy',
                                              'km',
                                            ).format(empData.dob)
                                            : '-',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("លេខទូរស័ព្ទ"),
                                      trailing: Text(
                                        empData.phone,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("អ៊ីមែល"),
                                      trailing: Text(
                                        empData.email,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("ប្រភេទបុគ្គលិក"),
                                      trailing: Text(
                                        empData.typeEmp,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("អាសយដ្ឋាន"),
                                      trailing: Text(
                                        empData.address,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("ថ្ងៃចូលបម្រើការងារ"),
                                      trailing: Text(
                                        empData.startDate != null
                                            ? ' ${DateFormat('dd MMM yyyy', 'km').format(empData.startDate)}'
                                            : '-',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                // Second
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FutureBuilder<EmpData?>(
                      future: fetchEmployeeData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox.shrink();
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('កំហុស៖ ${snapshot.error}'),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                            child: Text('មិនមានទិន្នន័យបុគ្គលិក'),
                          );
                        }
                        final empData = snapshot.data!;
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'ព័ត៌មានការងារ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text("ឈ្មោះប្រធាន"),
                                  trailing: Text(
                                    empData.adminname,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: const Text("សាខា"),
                                  trailing: Text(
                                    empData.branch,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: Text("ផ្នែក"),
                                  trailing: Text(
                                    empData.section,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: Text("មុខតំណែង"),
                                  trailing: Text(
                                    empData.workname,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: Text("របៀបទូទាត់"),
                                  trailing: Text(
                                    empData.paidBy,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: Text("ឈ្មោះគណនី"),
                                  trailing: Text(
                                    empData.accName.isNotEmpty
                                        ? empData.accName
                                        : 'ទទេ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: Text("លេខគណនី"),
                                  trailing: Text(
                                    empData.accNumber.isNotEmpty
                                        ? empData.accNumber
                                        : 'ទទេ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  title: Text("ប្រាក់ខែគោល"),
                                  trailing: Text(
                                    '\$${empData.baseSal}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
