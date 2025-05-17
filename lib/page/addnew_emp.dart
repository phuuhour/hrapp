// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr/widget/Button.dart';
import 'package:hr/widget/Dropdownlist.dart';
import 'package:hr/widget/TextField.dart';

class AddnewEmp extends StatefulWidget {
  const AddnewEmp({super.key});

  @override
  State<AddnewEmp> createState() => _AddnewEmpState();
}

class _AddnewEmpState extends State<AddnewEmp> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int currentStep = 0;

  // Controllers
  final TextEditingController _empId = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nationalId = TextEditingController();
  final TextEditingController _typeemp = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _workname = TextEditingController();
  final TextEditingController _paidby = TextEditingController();
  final TextEditingController _accname = TextEditingController();
  final TextEditingController _accnumber = TextEditingController();
  final TextEditingController _basesal = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _section = TextEditingController();

  List<String> existingEmpIds = [];
  List<String> empIdItems = [];
  List<String> sectionItems = [];
  List<String> workNameItems = [];

  @override
  void initState() {
    super.initState();
    _loadExistingEmpIds();
    _workname.addListener(_generateEmpIdBasedOnWorkName);
    _branch.addListener(_loadSectionsForBranch);
    _section.addListener(_loadWorkNamesForSection);
  }

  void _loadExistingEmpIds() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    setState(() {
      existingEmpIds =
          querySnapshot.docs.map((doc) => doc['empId'] as String).toList();
    });
  }

  void _loadSectionsForBranch() async {
    if (_branch.text.isEmpty) return;

    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('works')
            .where('branch', isEqualTo: _branch.text)
            .get();

    final sections =
        querySnapshot.docs
            .map((doc) => doc['section'] as String)
            .toSet()
            .toList();

    setState(() {
      sectionItems = sections;
      _section.clear();
      _workname.clear();
      _empId.clear();
    });
  }

  void _loadWorkNamesForSection() async {
    if (_branch.text.isEmpty || _section.text.isEmpty) return;

    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('works')
            .where('branch', isEqualTo: _branch.text)
            .where('section', isEqualTo: _section.text)
            .get();

    final workNames =
        querySnapshot.docs
            .map((doc) => doc['workName'] as String)
            .toSet()
            .toList();

    setState(() {
      workNameItems = workNames;
      _workname.clear();
      _empId.clear();
    });
  }

  void _generateEmpIdBasedOnWorkName() {
    if (_workname.text.trim().length >= 3) {
      String generated = generateEmpId(_workname.text.trim(), existingEmpIds);
      setState(() {
        empIdItems = [generated];
        _empId.text = generated;
      });
    }
  }

  String generateEmpId(String workId, List<String> existingIds) {
    String newId;
    Random random = Random();
    int attempts = 0;

    do {
      int num = 100 + random.nextInt(900);
      newId = '${workId}_$num';
      attempts++;

      if (attempts > 100) {
        newId =
            '${workId}_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
        break;
      }
    } while (existingIds.contains(newId));

    return newId;
  }

  @override
  void dispose() {
    _empId.dispose();
    _fullname.dispose();
    _gender.dispose();
    _dob.dispose();
    _phone.dispose();
    _email.dispose();
    _nationalId.dispose();
    _typeemp.dispose();
    _address.dispose();
    _startDate.dispose();
    _branch.dispose();
    _section.dispose();
    _workname.dispose();
    _paidby.dispose();
    _accname.dispose();
    _accnumber.dispose();
    _basesal.dispose();
    super.dispose();
  }

  void addEmployee() async {
    if (_formKey.currentState!.validate()) {
      // Validate all required fields
      if (_empId.text.isEmpty ||
          _fullname.text.isEmpty ||
          _gender.text.isEmpty ||
          _dob.text.isEmpty ||
          _phone.text.isEmpty ||
          _email.text.isEmpty ||
          _nationalId.text.isEmpty ||
          _typeemp.text.isEmpty ||
          _address.text.isEmpty ||
          _startDate.text.isEmpty ||
          _branch.text.isEmpty ||
          _section.text.isEmpty ||
          _workname.text.isEmpty ||
          _paidby.text.isEmpty ||
          _basesal.text.isEmpty) {
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

      // Regular expressions for validation
      final fullname = RegExp(r'^[a-zA-Z\u1780-\u17FF\s]+$');
      final numberReg = RegExp(r'^[0-9]+$');
      final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if (!fullname.hasMatch(_fullname.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ឈ្មោះពេញត្រូវតែជាអក្សរ',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!numberReg.hasMatch(_phone.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'លេខទូរស័ព្ទត្រូវតែមានតែលេខប៉ុណ្ណោះ',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!emailReg.hasMatch(_email.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'អុីមែលមិនត្រឹមត្រូវទេ',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!numberReg.hasMatch(_nationalId.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'អត្តសញ្ញាណប័ត្រត្រូវតែមានតែលេខប៉ុណ្ណោះ',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (int.tryParse(_basesal.text.trim()) == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ប្រាក់ខែគោលត្រូវតែជាលេខ',
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

      try {
        // Parse dates first to ensure they're valid
        final dobDate = DateTime.parse(_dob.text.trim());
        final startDate = DateTime.parse(_startDate.text.trim());

        final empData = {
          'empId': _empId.text.trim(),
          'fullname': _fullname.text.trim(),
          'gender': _gender.text.trim(),
          'dob': dobDate,
          'phone': _phone.text.trim(),
          'email': _email.text.trim(),
          'nationalId': _nationalId.text.trim(),
          'typeEmp': _typeemp.text.trim(),
          'address': _address.text.trim(),
          'startDate': startDate,
          'branch': _branch.text.trim(),
          'section': _section.text.trim(),
          'workname': _workname.text.trim(),
          'paidBy': _paidby.text.trim(),
          'accName': _accname.text.trim(),
          'accNumber': _accnumber.text.trim(),
          'baseSal': _basesal.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        };

        // Add to Firestore
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(_empId.text.trim())
            .set(empData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'បុគ្គលិកថ្មីត្រូវបានបន្ថែមដោយជោគជ័យ!',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.blue,
          ),
        );

        // Clear all fields
        _empId.clear();
        _fullname.clear();
        _gender.clear();
        _dob.clear();
        _phone.clear();
        _email.clear();
        _nationalId.clear();
        _typeemp.clear();
        _address.clear();
        _startDate.clear();
        _branch.clear();
        _section.clear();
        _workname.clear();
        _paidby.clear();
        _accname.clear();
        _accnumber.clear();
        _basesal.clear();

        // Reset to first step
        setState(() {
          currentStep = 0;
        });
      } on FormatException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'ទំរង់កាលបរិច្ឆេទមិនត្រឹមត្រូវ',
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'មានបញ្ហាក្នុងការបន្ថែមបុគ្គលិក: $error',
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "បន្ថែមបុគ្គលិកថ្មី",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Boxicons.bx_x, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Work Info (Step 0)
                if (currentStep == 0) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'ព័ត៌មានការងារ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'ទីតាំងការងារ(សាខា)',
                    items: const [
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
                    hint: 'សូមជ្រើសរើស',
                    controller: _branch,
                    icon: Icons.arrow_drop_down,
                    onChanged: (items) {
                      if (items != null) {
                        setState(() {
                          _branch.text = items;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'ផ្នែកការងារ',
                    items: sectionItems,
                    hint:
                        _branch.text.isEmpty
                            ? 'សូមជ្រើសរើសសាខាជាមុនសិន'
                            : 'ជ្រើសរើសផ្នែក',
                    controller: _section,
                    icon: Icons.arrow_drop_down,
                    onChanged: (items) {
                      if (items != null) {
                        setState(() {
                          _section.text = items;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'មុខងារ',
                    items: workNameItems,
                    hint:
                        _section.text.isEmpty
                            ? 'សូមជ្រើសរើសផ្នែកជាមុនសិន'
                            : 'ជ្រើសរើសមុខងារ',
                    controller: _workname,
                    icon: Icons.arrow_drop_down,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _workname.text = value;
                        });
                      }
                    },
                  ),
                ],

                // Personal Info (Step 1)
                if (currentStep == 1) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'ព័ត៌មានបុគ្គលិក',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'លេខសម្គាល់បុគ្គលិក',
                    items: empIdItems,
                    hint: _workname.text.isEmpty ? 'លេខសម្គាល់' : 'លេខសម្គាល់',
                    icon: Icons.arrow_drop_down,
                    controller: _empId,
                    onChanged: (value) {
                      if (value != null) {
                        _empId.text = value;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'ឈ្មោះពេញ',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    keyboardType: TextInputType.text,
                    lendingIcon: false,
                    controller: _fullname,
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'ភេទ',
                    items: const ['ប្រុស', 'ស្រី'],
                    hint: '',
                    icon: Icons.arrow_drop_down,
                    controller: _gender,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'ថ្ងៃខែឆ្នាំកំណើត',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    isDate: true,
                    controller: _dob,
                    lendingIcon: false,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'លេខទូរស័ព្ទ',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    keyboardType: TextInputType.number,
                    lendingIcon: false,
                    controller: _phone,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'អ៊ីម៊ែល',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    keyboardType: TextInputType.emailAddress,
                    lendingIcon: false,
                    controller: _email,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'លេខអត្តសញ្ញាណប័ណ្ណ',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    keyboardType: TextInputType.number,
                    lendingIcon: false,
                    controller: _nationalId,
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'ប្រភេទបុគ្គលិក',
                    items: const ['កិច្ចសន្យា', 'ពេញម៉ោង', 'ក្រៅម៉ោង'],
                    hint: '',
                    icon: Icons.arrow_drop_down,
                    controller: _typeemp,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'អាសយដ្ឋាន',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    keyboardType: TextInputType.text,
                    lendingIcon: false,
                    controller: _address,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'ថ្ងៃចូលបំរើការងារ',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    isDate: true,
                    controller: _startDate,
                    keyboardType: TextInputType.text,
                    lendingIcon: false,
                  ),
                ],

                // Salary Info (Step 2)
                if (currentStep == 2) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'ព័ត៌មានប្រាក់ឈ្នួល',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownList(
                    label: 'បើកប្រាក់ដោយ',
                    items: const ['សាច់ប្រាក់', 'ធនាគារ'],
                    hint: '',
                    icon: Icons.arrow_drop_down,
                    controller: _paidby,
                    onChanged: (value) {
                      setState(() {
                        _paidby.text = value ?? '';
                        if (_paidby.text == 'សាច់ប្រាក់') {
                          _accname.clear();
                          _accnumber.clear();
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  if (_paidby.text == 'ធនាគារ') ...[
                    CustomTextField(
                      label: 'ឈ្មោះគណនីធនាគារ',
                      hint: '',
                      icon: const Icon(Boxicons.bx_credit_card),
                      keyboardType: TextInputType.text,
                      lendingIcon: false,
                      controller: _accname,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'លេខគណនីធនាគារ',
                      hint: '',
                      icon: const Icon(Boxicons.bx_credit_card),
                      keyboardType: TextInputType.number,
                      lendingIcon: false,
                      controller: _accnumber,
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'ប្រាក់ខែគោល',
                    hint: '',
                    icon: const Icon(Boxicons.bx_credit_card),
                    keyboardType: TextInputType.number,
                    lendingIcon: false,
                    controller: _basesal,
                  ),
                ],

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: CustomButton(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 50,
                          text: "ថយក្រោយ",
                          onPressed: () {
                            setState(() {
                              currentStep--;
                            });
                          },
                          isLoading: false,
                        ),
                      ),
                    if (currentStep > 0)
                      const SizedBox(width: 10), // spacing between buttons
                    Expanded(
                      child: CustomButton(
                        color: Colors.blue,
                        width: double.infinity,
                        height: 50,
                        isLoading: isLoading,
                        text: currentStep < 2 ? "បន្ត" : "បញ្ជូន",
                        onPressed: () {
                          if (currentStep < 2) {
                            setState(() {
                              currentStep++;
                            });
                          } else {
                            addEmployee();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
