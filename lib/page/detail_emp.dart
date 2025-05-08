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

  Future<void> deleteEmpById(String empId, BuildContext context) async {
    try {
      // First check if document exists
      final doc =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(empId)
              .get();

      if (!doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('បុគ្គលិកមិនត្រូវបានរកឃើញទេ!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Delete the document
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(empId)
          .delete();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('បុគ្គលិកត្រូវបានលុបដោយជោគជ័យ!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back twice to return to employee list
      Navigator.of(context)
        ..pop() // Close dialog
        ..pop(); // Return to previous screen
    } catch (e) {
      debugPrint('Error deleting employee: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('កំហុស៖ មិនអាចលុបបានទេ។ ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ព័ត៌មានបុគ្គលិក',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Boxicons.bxs_edit_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'លុបបុគ្គលិក',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    content: const Text(
                      'តើអ្នកប្រាកដថាចង់លុបបុគ្គលិកនេះមែនទេ?',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'បោះបង់',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop(); // Close dialog first
                          await deleteEmpById(widget.empId, context);
                        },
                        child: const Text(
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
            icon: const Icon(Boxicons.bxs_trash, color: Colors.white, size: 20),
          ),
        ],
      ),
      body: FutureBuilder<EmpData?>(
        future: fetchEmployeeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('កំហុស៖ ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('មិនមានទិន្នន័យបុគ្គលិក'));
          }

          final empData = snapshot.data!;
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image(
                    image: const AssetImage('assets/images/profile.png'),
                    fit: BoxFit.cover,
                    height: 250,
                    width: 250,
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                    shape: const Border(),
                    children: [
                      ListTile(
                        title: const Text("លេខសម្គាល់បុគ្គលិក"),
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
                          // ignore: unnecessary_null_comparison
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
                        title: Text("លេខអត្តសញ្ញាណប័ណ្ណ"),
                        trailing: Text(
                          empData.nationalId,
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
                          // ignore: unnecessary_null_comparison
                          empData.startDate != null
                              ? ' ${DateFormat('dd MMM yyyy', 'km').format(empData.startDate)}'
                              : '-',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('ព័ត៌មានការងារ'),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                    shape: const Border(),
                    children: [
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
                          empData.accName,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text("លេខគណនី"),
                        trailing: Text(
                          empData.accNumber,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text("ប្រាក់ខែគោល"),
                        trailing: Text(
                          empData.baseSal,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
