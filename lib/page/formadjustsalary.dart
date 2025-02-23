import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:hr/widget/customButton.dart';
import 'package:hr/widget/customDropdownField.dart';
import 'package:hr/widget/customTextField.dart';

class AdjustSalary extends StatefulWidget {
  const AdjustSalary({super.key});

  @override
  State<AdjustSalary> createState() => _AdjustSalaryState();
}

class _AdjustSalaryState extends State<AdjustSalary> {
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
          "ស្នើរបន្ថែមទឹកប្រាក់",
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
                'ចំណាំ៖ សំណើសុំកែសម្រួលប្រាក់ខែត្រូវដាក់ជូនអ្នកគ្រប់គ្រងយ៉ាងតិច 10 ថ្ងៃមុនការទូទាត់។',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'ចំណងជើងការងារ',
                hint: '',
                icon: Boxicons.bx_file,
              ),
              const SizedBox(height: 10),
              CustomDropdownField(
                label: 'ប្រភេទការងារ',
                items: ['ពេញម៉ោង', 'ក្រៅម៉ោង', 'កិច្ចសន្យា'],
                icon: Boxicons.bx_category,
                onChanged: (String? value) {
                  setState(() {
                    selectedWorkType = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'បរិយាយការងារ',
                hint: '',
                icon: Boxicons.bx_edit,
              ),
              const SizedBox(height: 10),
              CustomDropdownField(
                label: 'បុគ្គលិកដែលបានចាត់តាំង',
                items: ['John Doe', 'Jane Smith', 'Michael Johnson'],
                icon: Boxicons.bx_user,
                onChanged: (String? value) {
                  setState(() {
                    assignedWorker = value;
                  });
                },
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
                label: 'ថ្ងៃបញ្ចប់',
                hint: 'DD/MM/YYYY',
                icon: Boxicons.bx_calendar,
                isDate: true,
                controller: endDateController,
              ),
              const SizedBox(height: 10),
              CustomDropdownField(
                label: 'ស្ថានភាពការងារ',
                items: ['កំពុងដំណើរការ', 'បញ្ចប់', 'បានលុប'],
                icon: Boxicons.bx_list_check,
                onChanged: (String? value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
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
              const SizedBox(height: 20),
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
