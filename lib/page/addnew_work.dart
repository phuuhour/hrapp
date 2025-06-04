// ignore_for_file: use_build_context_synchronously

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HR/widget/Button.dart';
import 'package:HR/widget/Dropdownlist.dart';
import 'package:HR/widget/TextField.dart';

class AddNewWork extends StatefulWidget {
  const AddNewWork({super.key});

  @override
  State<AddNewWork> createState() => _AddNewWorkState();
}

class _AddNewWorkState extends State<AddNewWork> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isAddingSection = false;

  // Controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _workIdController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _payrollController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _workIdController.dispose();
    _workNameController.dispose();
    _branchController.dispose();
    _payrollController.dispose();
    _sectionController.dispose();
    super.dispose();
  }

  void addWork() async {
    if (_formKey.currentState!.validate()) {
      final workId = _workIdController.text.trim();
      final section = _sectionController.text.trim();
      final workName = _workNameController.text.trim();
      final date = _dateController.text.trim();
      final branch = _branchController.text.trim();
      final payroll = _payrollController.text.trim();

      if (workId.isEmpty ||
          workName.isEmpty ||
          date.isEmpty ||
          branch.isEmpty ||
          section.isEmpty ||
          payroll.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'សូមបំពេញព័ត៌មានទាំងអស់',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (int.tryParse(payroll) == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ប្រាក់បៀវត្សត្រូវតែជាលេខ',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      FirebaseFirestore.instance
          .collection('works')
          .where('workId', isEqualTo: workId)
          .get()
          .then((querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'លេខសម្គាល់ការងារនេះមានរួចហើយ',
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            FirebaseFirestore.instance
                .collection('works')
                .add({
                  'workId': workId,
                  'section': section,
                  'workName': workName,
                  'date': date,
                  'branch': branch,
                  'payroll': int.parse(payroll),
                })
                .then((_) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'ការងារថ្មីត្រូវបានបន្ថែមដោយជោគជ័យ!',
                        style: TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _workIdController.clear();
                  _workNameController.clear();
                  _dateController.clear();
                  _branchController.clear();
                  _payrollController.clear();
                  _sectionController.clear();
                  _branchController.clear();
                })
                .catchError((error) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'មានបញ្ហាក្នុងការបន្ថែមការងារ: $error',
                        style: const TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
          });
    }
  }

  Future<void> addSection(String sectionName) async {
    try {
      await FirebaseFirestore.instance.collection('sections').add({
        'sectionname': sectionName,
      });
    } catch (e) {
      ('Error adding section: $e');
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
        title: const Text('បន្ថែមការងារថ្មី', style: TextStyle(fontSize: 16)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text("ព័ត៌មានការងារ", style: TextStyle(fontSize: 16)),
                    Divider(color: Colors.grey.withOpacity(0.4), thickness: 1),
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'លេខសម្គាល់ការងារ',
                      hint: 'លេខសម្គាល់ការងារ',
                      icon: const Icon(Boxicons.bx_credit_card),
                      keyboardType: TextInputType.text,
                      lendingIcon: false,
                      controller: _workIdController,
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('sections')
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        final sections =
                            snapshot.data!.docs.map((doc) {
                              return doc['sectionName'] as String;
                            }).toList();
                        return CustomDropdownList(
                          label: 'ផ្នែក',
                          controller: _sectionController,
                          hint: 'ផ្នែក​',
                          icon: Icons.arrow_drop_down,
                          items: sections,
                          onChanged: (value) {
                            setState(() {
                              _sectionController.text = value!;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'ឈ្មោះការងារ',
                      hint: 'ឈ្មោះការងារ',
                      icon: const Icon(Boxicons.bx_credit_card),
                      keyboardType: TextInputType.text,
                      lendingIcon: false,
                      controller: _workNameController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'ថ្ងៃចាប់ផ្តើម',
                      hint: 'ថ្ងៃចាប់ផ្តើម',
                      icon: const Icon(Boxicons.bx_credit_card),
                      isDate: true,
                      controller: _dateController,
                      lendingIcon: false,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    CustomDropdownList(
                      label: 'ទីតាំងការងារ(សាខា)',
                      items: [
                        'បន្ទាយមានជ័យ',
                        'បាត់ដំបង',
                        'កំពង់ចាម',
                        'កំពង់ឆ្នាំង',
                        'កំពង់ស្ពឺ',
                        'កំពង់ធំ',
                        'កំពត',
                        'កណ្ដាល',
                        'កោះកុង',
                        'ក្រចេះ',
                        'មណ្ឌលគិរី',
                        'ភ្នំពេញ',
                        'ព្រះវិហារ',
                        'ព្រៃវែង',
                        'ពោធិ៍សាត់',
                        'រតនគិរី',
                        'សៀមរាប',
                        'ព្រះសីហនុ',
                        'ស្ទឹងត្រែង',
                        'ស្វាយរៀង',
                        'តាកែវ',
                        'ឧត្តរមានជ័យ',
                        'ប៉ៃលិន',
                        'ត្បូងឃ្មុំ',
                      ],
                      hint: 'ទីតាំងការងារ(សាខា)',
                      controller: _branchController,
                      icon: Icons.arrow_drop_down,
                      onChanged: (items) {
                        if (items != null) {
                          setState(() {
                            _branchController.text = items;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'ប្រាក់បៀវត្ស(គិតក្នុង១ឆ្នាំម្តង)',
                      hint: 'ប្រាក់បៀវត្ស(គិតក្នុង១ឆ្នាំម្តង)',
                      icon: const Icon(Boxicons.bx_credit_card),
                      keyboardType: TextInputType.number,
                      lendingIcon: false,
                      controller: _payrollController,
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      color: Colors.blue,
                      width: double.infinity,
                      height: 50,
                      isLoading: isLoading,
                      text: "បញ្ជូន",
                      onPressed: () {
                        addWork();
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
