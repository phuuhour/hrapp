// ignore_for_file: use_build_context_synchronously

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr/model/empaccount.dart';
import 'package:hr/model/empdata.dart';
import 'package:hr/widget/Button.dart';
import 'package:hr/widget/Dropdownlist.dart';
import 'package:hr/widget/TextField.dart';
import 'package:intl/date_symbol_data_local.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  bool isLoading = false;

  List<EmpData> employees = [];
  List<String> fullnameItems = [];
  String? selectedEmpId;

  final Map<String, String> fullnameToEmpId = {};

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('km', null);
    _loadEmployees();
  }

  void _loadEmployees() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    setState(() {
      employees =
          querySnapshot.docs.map((doc) => EmpData.fromMap(doc.data())).toList();

      fullnameItems = employees.map((e) => e.fullname).toList();

      for (var employee in employees) {
        fullnameToEmpId[employee.fullname] = employee.empId;
      }
    });
  }

  Future<bool> _isPhoneUnique(String phone) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('empacc')
            .where('phone', isEqualTo: phone)
            .get();
    return snapshot.docs.isEmpty;
  }

  void _clearFields() {
    fullnameController.clear();
    phoneController.clear();
    passwordController.clear();
    selectedEmpId = null;
  }

  @override
  Widget build(BuildContext context) {
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
          'បង្កើតគណនីបុគ្គលិក',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            CustomDropdownList(
              label: 'ឈ្មោះបុគ្គលិក',
              items: fullnameItems,
              hint: 'សូមជ្រើសរើសឈ្មោះ',
              icon: Icons.arrow_drop_down,
              controller: fullnameController,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    fullnameController.text = value;
                    phoneController.text =
                        employees
                            .firstWhere((emp) => emp.fullname == value)
                            .phone;
                    selectedEmpId = fullnameToEmpId[value];
                  });
                }
              },
            ),
            const SizedBox(height: 10),

            CustomTextField(
              label: "លេខទូរស័ព្ទ",
              hint: '0123xxxxxx',
              icon: const Icon(Icons.phone),
              lendingIcon: false,
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),

            const SizedBox(height: 10),

            CustomTextField(
              label: "ពាក្យសម្ងាត់ថ្មី",
              isPassword: true,
              hint: 'បញ្ចូលពាក្យសម្ងាត់',
              icon: const Icon(Boxicons.bxs_lock),
              lendingIcon: false,
              keyboardType: TextInputType.text,
              controller: passwordController,
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 40),

            CustomButton(
              color: Colors.teal,
              width: MediaQuery.of(context).size.width,
              height: 50,
              isLoading: isLoading,
              text: 'បង្កើតគណនី',
              onPressed: () async {
                if (fullnameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('សូមបំពេញព័ត៌មានចាំបាច់'),
                      backgroundColor: Colors.teal,
                    ),
                  );
                  return;
                }

                if (selectedEmpId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('សូមជ្រើសរើសបុគ្គលិក')),
                  );
                  return;
                }

                setState(() => isLoading = true);

                try {
                  final isUnique = await _isPhoneUnique(phoneController.text);
                  if (!isUnique) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('លេខទូរស័ព្ទនេះបានប្រើរួចហើយ'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    setState(() => isLoading = false);
                    return;
                  }

                  // Check if empId already has an account
                  final existingAcc =
                      await FirebaseFirestore.instance
                          .collection('empacc')
                          .doc(selectedEmpId)
                          .get();
                  if (existingAcc.exists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('បុគ្គលិកនេះមានគណនីរួចហើយ'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    setState(() => isLoading = false);
                    return;
                  }

                  final empAccount = EmpAccount(
                    empId: selectedEmpId!,
                    fullname: fullnameController.text,
                    phone: phoneController.text,
                    password: passwordController.text,
                  );

                  final data = empAccount.toMap();
                  data['createdAt'] = FieldValue.serverTimestamp();

                  await FirebaseFirestore.instance
                      .collection('empacc')
                      .doc(selectedEmpId)
                      .set(data);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('គណនីត្រូវបានបង្កើតដោយជោគជ័យ'),
                      backgroundColor: Colors.teal,
                    ),
                  );

                  _clearFields();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('កំហុស: ${e.toString()}')),
                  );
                } finally {
                  setState(() => isLoading = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
