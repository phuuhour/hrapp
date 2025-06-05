// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HR/model/adminaccount.dart';
import 'package:HR/widget/Dropdownlist.dart';
import 'package:HR/widget/TextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddnewEmp extends StatefulWidget {
  const AddnewEmp({super.key});

  @override
  State<AddnewEmp> createState() => _AddnewEmpState();
}

class _AddnewEmpState extends State<AddnewEmp> {
  // Global Key for the Form
  final _formKey = GlobalKey<FormState>();
  // Loading state
  bool isLoading = false;
  // Current step in the form
  int currentStep = 0;

  // Controllers
  final TextEditingController _empId = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _adminname = TextEditingController();
  final TextEditingController _typeemp = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _workId = TextEditingController();
  final TextEditingController _paidby = TextEditingController();
  final TextEditingController _accname = TextEditingController();
  final TextEditingController _accnumber = TextEditingController();
  final TextEditingController _basesal = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _section = TextEditingController();

  // Lists for dropdown items
  List<String> existingEmpIds = [];
  List<String> empIdItems = [];
  List<String> sectionItems = [];
  List<String> workNameItems = [];
  List<String> adminFullnames = [];

  @override
  void initState() {
    super.initState();
    // _loadExistingEmpIds();
    _workId.addListener(_generateEmpIdBasedOnWorkId);
    _branch.addListener(_loadSectionsForBranch);
    _section.addListener(_loadWorkNamesForSection);
    _loadCurrentAdmin();
  }

  // Load current admin from SharedPreferences
  void _loadCurrentAdmin() async {
    // Get the admin phone number from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final adminPhone = prefs.getString('adminPhone');

    if (adminPhone != null) {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('adminacc')
              .where('phone', isEqualTo: adminPhone)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        final admin = AdminAccount.fromMap(snapshot.docs.first.data());

        setState(() {
          adminFullnames = [admin.fullname];
          _adminname.text = admin.fullname;
        });
      }
    }
  }

  // void _loadExistingEmpIds() async {
  //   final querySnapshot =
  //       await FirebaseFirestore.instance.collection('employees').get();

  //   setState(() {
  //     existingEmpIds =
  //         querySnapshot.docs.map((doc) => doc['empId'] as String).toList();
  //   });
  // }

  // Load sections based on selected branch
  void _loadSectionsForBranch() async {
    if (_branch.text.isEmpty) {
      setState(() {
        sectionItems = ['សូមជ្រើសរើសសាខាជាមុនសិន'];
        workNameItems = ['សូមជ្រើសរើសផ្នែកជាមុនសិន'];
      });
      return;
    }

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
      sectionItems = sections; // actual selectable items only
      _section.clear(); // Reset section selection
      _workId.clear(); // Reset workName selection
      workNameItems = []; // Clear work names completely
    });
  }

  // Load work names based on selected branch and section
  void _loadWorkNamesForSection() async {
    if (_branch.text.isEmpty || _section.text.isEmpty) {
      setState(() {
        workNameItems = ['សូមជ្រើសរើសផ្នែកជាមុនសិន']; // Default hint
      });
      return;
    }

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
      _workId.clear();
      _empId.clear();
    });
  }

  // Generate employee ID based on work ID
  void _generateEmpIdBasedOnWorkId() async {
    if (_workId.text.trim().isEmpty ||
        _branch.text.isEmpty ||
        _section.text.isEmpty) {
      return;
    }

    // Fetch the workId from Firestore based on branch, section, and workname
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('works')
            .where('branch', isEqualTo: _branch.text)
            .where('section', isEqualTo: _section.text)
            .where('workName', isEqualTo: _workId.text)
            .limit(1)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final workId = querySnapshot.docs.first['workId'] as String;
      String generated = generateEmpId(workId, existingEmpIds);
      setState(() {
        empIdItems = [generated];
        _empId.text = generated;
      });
    }
  }

  // Generate a unique employee ID
  String generateEmpId(String workId, List<String> existingIds) {
    String newId;
    Random random = Random();
    int attempts = 0;

    do {
      int num = 100 + random.nextInt(999);
      newId = '${workId}_$num';
      attempts++;

      if (attempts > 100) {
        newId =
            '${workId}_${DateTime.now().millisecondsSinceEpoch.toString().substring(3)}';
        break;
      }
    } while (existingIds.contains(newId));

    return newId;
  }

  // Dispose of controllers
  @override
  void dispose() {
    _empId.dispose();
    _fullname.dispose();
    _gender.dispose();
    _dob.dispose();
    _phone.dispose();
    _email.dispose();
    _adminname.dispose();
    _typeemp.dispose();
    _address.dispose();
    _startDate.dispose();
    _branch.dispose();
    _section.dispose();
    _workId.dispose();
    _paidby.dispose();
    _accname.dispose();
    _accnumber.dispose();
    _basesal.dispose();
    super.dispose();
  }

  // Function to add a new employee
  void addEmployee() async {
    if (_formKey.currentState!.validate()) {
      // Validate all required fields
      if (_empId.text.isEmpty ||
          _fullname.text.isEmpty ||
          _gender.text.isEmpty ||
          _dob.text.isEmpty ||
          _phone.text.isEmpty ||
          _email.text.isEmpty ||
          _adminname.text.isEmpty ||
          _typeemp.text.isEmpty ||
          _address.text.isEmpty ||
          _startDate.text.isEmpty ||
          _branch.text.isEmpty ||
          _section.text.isEmpty ||
          _workId.text.isEmpty ||
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

      // Try to add the employee data to Firestore
      try {
        final dobDate = DateTime.parse(_dob.text.trim());
        final startDate = DateTime.parse(_startDate.text.trim());

        final empData = {
          'empId': _empId.text.trim(),
          'fullname': _fullname.text.trim(),
          'gender': _gender.text.trim(),
          'dob': dobDate,
          'phone': _phone.text.trim(),
          'email': _email.text.trim(),
          'adminname': _adminname.text.trim(),
          'typeEmp': _typeemp.text.trim(),
          'address': _address.text.trim(),
          'startDate': startDate,
          'branch': _branch.text.trim(),
          'section': _section.text.trim(),
          'workname': _workId.text.trim(),
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
        _adminname.clear();
        _typeemp.clear();
        _address.clear();
        _startDate.clear();
        _branch.clear();
        _section.clear();
        _workId.clear();
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
      backgroundColor: Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('បុគ្គលិកថ្មី', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black45),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          // Use the global key for the form
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentStep == 0) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 25,
                    ),
                    child: Column(
                      children: [
                        Text("ព័ត៌មានការងារ", style: TextStyle(fontSize: 16)),
                        Divider(
                          color: Colors.grey.withOpacity(0.4),
                          thickness: 1,
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
                          hint:
                              _branch.text.isEmpty
                                  ? 'សូមជ្រើសរើសសាខាជាមុនសិន'
                                  : (sectionItems.isEmpty
                                      ? 'មិនមានផ្នែកក្នុងសាខានេះទេ'
                                      : 'ជ្រើសរើសផ្នែក'),
                          controller: _branch,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _branch.text = value;
                              });
                            }
                          },
                          icon: Icons.arrow_drop_down,
                        ),
                        const SizedBox(height: 15),
                        CustomDropdownList(
                          label: 'ផ្នែកការងារ',
                          items: sectionItems,
                          hint:
                              _branch.text.isEmpty
                                  ? 'សូមជ្រើសរើសសាខាជាមុនសិន'
                                  : (sectionItems.isEmpty
                                      ? 'មិនមានផ្នែកក្នុងសាខានេះទេ'
                                      : 'ជ្រើសរើសផ្នែក'),
                          controller: _section,
                          onChanged: (value) {
                            if (value != null &&
                                value != 'សូមជ្រើសរើសសាខាជាមុនសិន') {
                              setState(() {
                                _section.text = value;
                              });
                            }
                          },
                          icon: Icons.arrow_drop_down,
                        ),
                        const SizedBox(height: 15),
                        CustomDropdownList(
                          label: 'មុខងារ',
                          items: workNameItems,
                          hint:
                              _section.text.isEmpty
                                  ? 'សូមជ្រើសរើសផ្នែកជាមុនសិន'
                                  : (workNameItems.isEmpty
                                      ? 'មិនមានការងារក្នុងផ្នែកនេះទេ'
                                      : 'ជ្រើសរើសការងារ'),

                          controller: _workId,
                          onChanged: (value) {
                            if (value != null &&
                                value != 'សូមជ្រើសរើសផ្នែកជាមុនសិន') {
                              setState(() {
                                _workId.text = value;
                              });
                            }
                          },
                          icon: Icons.arrow_drop_down,
                        ),
                        const SizedBox(height: 15),
                        CustomDropdownList(
                          label: 'អ្នកគ្រប់គ្រង',
                          items: adminFullnames,
                          hint: 'អ្នកគ្រប់គ្រង',
                          icon: Icons.arrow_drop_down,
                          controller: _adminname,
                          onChanged: (value) {},
                        ),

                        const SizedBox(height: 40),
                        // Navigation Buttons for Step 0
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "លុប",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed:
                                      isLoading
                                          ? null
                                          : () {
                                            setState(() {
                                              currentStep++;
                                            });
                                          },
                                  child:
                                      isLoading
                                          ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : const Text(
                                            "បន្ត",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                if (currentStep == 1) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 25,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'ព័ត៌មានបុគ្គលិក',
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.4),
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        CustomDropdownList(
                          label: 'លេខសម្គាល់បុគ្គលិក',
                          items: empIdItems,
                          hint:
                              _workId.text.isEmpty
                                  ? 'លេខសម្គាល់'
                                  : 'លេខសម្គាល់',
                          icon: Icons.arrow_drop_down,
                          controller: _empId,
                          onChanged: (value) {
                            if (value != null) {
                              _empId.text = value;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'ឈ្មោះពេញ',
                          hint: 'ឈ្មោះពេញ',
                          icon: const Icon(Boxicons.bx_credit_card),
                          keyboardType: TextInputType.text,
                          lendingIcon: false,
                          controller: _fullname,
                        ),
                        const SizedBox(height: 15),
                        CustomDropdownList(
                          label: 'ភេទ',
                          items: const ['ប្រុស', 'ស្រី'],
                          hint: 'ភេទ',
                          icon: Icons.arrow_drop_down,
                          controller: _gender,
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'ថ្ងៃខែឆ្នាំកំណើត',
                          hint: 'ថ្ងៃខែឆ្នាំកំណើត',
                          icon: const Icon(Boxicons.bx_credit_card),
                          isDate: true,
                          controller: _dob,
                          lendingIcon: false,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'លេខទូរស័ព្ទ',
                          hint: 'លេខទូរស័ព្ទ',
                          icon: const Icon(Boxicons.bx_credit_card),
                          keyboardType: TextInputType.number,
                          lendingIcon: false,
                          controller: _phone,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'អ៊ីម៊ែល',
                          hint: 'អ៊ីម៊ែល',
                          icon: const Icon(Boxicons.bx_credit_card),
                          keyboardType: TextInputType.emailAddress,
                          lendingIcon: false,
                          controller: _email,
                        ),
                        const SizedBox(height: 15),

                        CustomDropdownList(
                          label: 'ប្រភេទបុគ្គលិក',
                          items: const ['កិច្ចសន្យា', 'ពេញម៉ោង', 'ក្រៅម៉ោង'],
                          hint: 'ប្រភេទបុគ្គលិក',
                          icon: Icons.arrow_drop_down,
                          controller: _typeemp,
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'អាសយដ្ឋាន',
                          hint: 'អាសយដ្ឋាន',
                          icon: const Icon(Boxicons.bx_credit_card),
                          keyboardType: TextInputType.text,
                          lendingIcon: false,
                          controller: _address,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'ថ្ងៃចូលបំរើការងារ',
                          hint: 'ថ្ងៃចូលបំរើការងារ',
                          icon: const Icon(Boxicons.bx_credit_card),
                          isDate: true,
                          controller: _startDate,
                          keyboardType: TextInputType.text,
                          lendingIcon: false,
                        ),
                        const SizedBox(height: 40),
                        // Navigation Buttons for Step 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      currentStep--;
                                    });
                                  },
                                  child: const Text(
                                    "ថយក្រោយ",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed:
                                      isLoading
                                          ? null
                                          : () {
                                            setState(() {
                                              currentStep++;
                                            });
                                          },
                                  child:
                                      isLoading
                                          ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : const Text(
                                            "បន្ត",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                if (currentStep == 2) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 25,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'ព័ត៌មានប្រាក់ខែ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.4),
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        CustomDropdownList(
                          label: 'បើកប្រាក់ដោយ',
                          items: const ['សាច់ប្រាក់', 'ធនាគារ'],
                          hint: 'បើកប្រាក់ដោយ',
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
                        const SizedBox(height: 15),
                        if (_paidby.text == 'ធនាគារ') ...[
                          CustomTextField(
                            label: 'ឈ្មោះគណនីធនាគារ',
                            hint: 'ឈ្មោះគណនីធនាគារ',
                            icon: const Icon(Boxicons.bx_credit_card),
                            keyboardType: TextInputType.text,
                            lendingIcon: false,
                            controller: _accname,
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            label: 'លេខគណនីធនាគារ',
                            hint: 'លេខគណនីធនាគារ',
                            icon: const Icon(Boxicons.bx_credit_card),
                            keyboardType: TextInputType.number,
                            lendingIcon: false,
                            controller: _accnumber,
                          ),
                          const SizedBox(height: 15),
                        ],
                        CustomTextField(
                          label: 'ប្រាក់ខែគោល',
                          hint: 'ប្រាក់ខែគោល',
                          icon: const Icon(Boxicons.bx_credit_card),
                          keyboardType: TextInputType.number,
                          lendingIcon: false,
                          controller: _basesal,
                        ),
                        const SizedBox(height: 40),
                        // Navigation Buttons for Step 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      currentStep--;
                                    });
                                  },
                                  child: const Text(
                                    "ថយក្រោយ",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed:
                                      isLoading
                                          ? null
                                          : () {
                                            addEmployee();
                                          },
                                  child:
                                      isLoading
                                          ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : const Text(
                                            "បញ្ជូន",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
