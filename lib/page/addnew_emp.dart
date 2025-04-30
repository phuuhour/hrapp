// ignore_for_file: use_build_context_synchronously

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/empdata.dart';
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

  // Stream for sections based on selected branch
  Stream<QuerySnapshot> getSectionsStream(String? branch) {
    if (branch == null || branch.isEmpty) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('works')
        .where('branch', isEqualTo: branch)
        .snapshots();
  }

  // Stream for work names based on selected branch and section
  Stream<QuerySnapshot> getWorkNamesStream(String? branch, String? section) {
    if (branch == null ||
        branch.isEmpty ||
        section == null ||
        section.isEmpty) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('works')
        .where('branch', isEqualTo: branch)
        .where('section', isEqualTo: section)
        .snapshots();
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
      // Check empty fields first
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
          _accname.text.isEmpty ||
          _accnumber.text.isEmpty ||
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

      // Validation
      final fullnameReg = RegExp(
        r'^[\p{L}\s]+$',
        unicode: true,
      ); // allow all languages + space
      final numberReg = RegExp(r'^[0-9]+$');
      final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if (!fullnameReg.hasMatch(_fullname.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ឈ្មោះត្រូវតែមានតែអក្សរប៉ុណ្ណោះ',
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

      if (!fullnameReg.hasMatch(_accname.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ឈ្មោះគណនីត្រូវតែមានតែអក្សរប៉ុណ្ណោះ',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!numberReg.hasMatch(_accnumber.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'លេខគណនីត្រូវតែមានតែលេខប៉ុណ្ណោះ',
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

      // If all validations pass
      setState(() {
        isLoading = true;
      });

      final newEmployee = EmpData(
        empId: _empId.text.trim(),
        fullname: _fullname.text.trim(),
        gender: _gender.text.trim(),
        dob: DateTime.parse(_dob.text.trim()),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        nationalId: _nationalId.text.trim(),
        typeEmp: _typeemp.text.trim(),
        address: _address.text.trim(),
        startDate: DateTime.parse(_startDate.text.trim()),
        paidBy: _paidby.text.trim(),
        accName: _accname.text.trim(),
        accNumber: _accnumber.text.trim(),
        baseSal: _basesal.text.trim(),
      );

      FirebaseFirestore.instance
          .collection('employees')
          .where('empId', isEqualTo: newEmployee.empId)
          .get()
          .then((querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'លេខសម្គាល់បុគ្គលិកនេះមានរួចហើយ',
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            FirebaseFirestore.instance
                .collection('employees')
                .add(newEmployee.toMap())
                .then((_) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'បុគ្គលិកថ្មីត្រូវបានបន្ថែមដោយជោគជ័យ!',
                        style: TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
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
                })
                .catchError((error) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'មានបញ្ហាក្នុងការបន្ថែមបុគ្គលិក: $error',
                        style: const TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
          });
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
                const SizedBox(height: 20),
                const Text(
                  'ព័ត៌មានបុគ្គលិក',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខសម្គាល់បុគ្គលិក',
                  hint: '',
                  icon: const Icon(Boxicons.bx_credit_card),
                  keyboardType: TextInputType.number,
                  lendingIcon: false,
                  controller: _empId,
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
                  keyboardType: TextInputType.text,
                  lendingIcon: false,
                  controller: _phone,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'អ៊ីម៊ែល',
                  hint: '',
                  icon: const Icon(Boxicons.bx_credit_card),
                  keyboardType: TextInputType.text,
                  lendingIcon: false,
                  controller: _email,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខអត្តសញ្ញាណប័ណ្ណ',
                  hint: '',
                  icon: const Icon(Boxicons.bx_credit_card),
                  keyboardType: TextInputType.text,
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
                        _section.clear();
                        _workname.clear();
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: getSectionsStream(_branch.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ');
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('មិនមានផ្នែកនៅសាខានេះទេ');
                    }

                    final sections =
                        snapshot.data!.docs
                            .map((doc) => doc['section'] as String)
                            .toSet()
                            .toList();

                    return CustomDropdownList(
                      label: 'ផ្នែកការងារ',
                      items: sections,
                      hint: 'ជ្រើសរើសផ្នែក',
                      controller: _section,
                      icon: Icons.arrow_drop_down,
                      onChanged: (items) {
                        if (items != null) {
                          setState(() {
                            _section.text = items;
                          });
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: getWorkNamesStream(_branch.text, _section.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ');
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('មិនមានមុខងារ​នៅក្នុងផ្នែកនេះទេ');
                    }

                    final workNames =
                        snapshot.data!.docs
                            .map((doc) => doc['workName'] as String)
                            .toSet()
                            .toList();

                    return CustomDropdownList(
                      label: 'មុខងារ',
                      items: workNames,
                      hint: 'ជ្រើសរើសមុខងារ',
                      controller: _workname,
                      icon: Icons.arrow_drop_down,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _workname.text = value;
                          });
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),
                const Text(
                  'ព័ត៌មានប្រាក់ឈ្នួល',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                CustomDropdownList(
                  label: 'បើកប្រាក់ដោយ',
                  items: const ['សាច់ប្រាក់', 'ធនាគារ', 'អេឡិចត្រូនិច'],
                  hint: '',
                  icon: Icons.arrow_drop_down,
                  controller: _paidby,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
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
                CustomTextField(
                  label: 'ប្រាក់ខែគោល',
                  hint: '',
                  icon: const Icon(Boxicons.bx_credit_card),
                  keyboardType: TextInputType.number,
                  lendingIcon: false,
                  controller: _basesal,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  isLoading: isLoading,
                  text: "បញ្ជូន",
                  onPressed: addEmployee,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
