import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:hr/widget/customButton.dart';
import 'package:hr/widget/customDropdownField.dart';
import 'package:hr/widget/customTextField.dart';

class AddNewWork extends StatefulWidget {
  const AddNewWork({super.key});

  @override
  State<AddNewWork> createState() => _AddNewWorkState();
}

class _AddNewWorkState extends State<AddNewWork> {
  bool isLoading = false;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String? selectedWorkType;
  String? selectedStatus;
  String? assignedWorker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "បន្ថែមការងារថ្មី",
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              const Text(
                'ព័ត៌មានការងារ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const Divider(),
              const SizedBox(height: 10),
              CustomDropdownField(
                label: 'ផ្នែក',
                items: ['IT', 'SERVICE', 'ACCOUNT'],
                icon: Boxicons.bx_list_check,
                onChanged: (String? value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ការងារ',
                hint: '',
                icon: Boxicons.bx_file,
              ),

              const SizedBox(height: 10),
              CustomTextField(
                label: 'ថ្ងៃចាប់ផ្តើម',
                hint: 'DD/MM/YYYY',
                icon: Boxicons.bx_calendar,
                isDate: true,
                controller: startDateController,
              ),

              const SizedBox(height: 10),
              CustomTextField(
                label: 'ចំនួនប្រាក់បៀវត្សរ៍',
                hint: '',
                icon: Boxicons.bx_money,
                controller: salaryController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'កំណត់ចំណាំ',
                hint: '',
                icon: Boxicons.bx_note,

                controller: notesController,
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: "បញ្ជូន",
                isLoading: isLoading,
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                isPrimary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
