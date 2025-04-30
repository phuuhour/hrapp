import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/widget/Button.dart';
import 'package:hr/widget/Dropdownlist.dart';
import 'package:hr/widget/TextField.dart';

class AdjustSalary extends StatefulWidget {
  const AdjustSalary({super.key});

  @override
  State<AdjustSalary> createState() => _AdjustSalaryState();
}

class _AdjustSalaryState extends State<AdjustSalary> {
  bool isLoading = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController salaryadd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ស្នើរបន្ថែមប្រាក់ខែ',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'រក្សាទុកពេលក្រោយ',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              const Text(
                'ចំណាំ៖ សំណើសុំបន្ថែមប្រាក់ខែត្រូវដាក់ជូនអ្នកគ្រប់គ្រងយ៉ាងតិច 10 ថ្ងៃមុនការទូទាត់។',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              CustomDropdownList(
                label: 'ផ្នែក',
                items: ['IT', 'Design', 'Accounting', 'HR'],
                hint: '',
                icon: Icons.arrow_drop_down,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              CustomDropdownList(
                label: 'ឈ្មោះការងារ',
                items: ['Mobile Programming', 'Web', 'HR', 'Marketing'],
                hint: '',
                icon: Icons.arrow_drop_down,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ចំនួនទឹកប្រាក់',
                lendingIcon: false,
                hint: '',
                icon: Icon(Boxicons.bx_credit_card),
                controller: salaryadd,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ថ្ងៃទទួលប្រាក់',
                hint: 'DD/MM/YYYY',
                icon: Icon(Boxicons.bx_credit_card),
                isDate: true,
                controller: dateController,
                lendingIcon: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'កំណត់ចំណាំ',
                lendingIcon: false,
                hint: '',
                icon: Icon(Boxicons.bx_credit_card),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 40),
              CustomButton(
                color: Colors.orangeAccent,
                width: MediaQuery.of(context).size.width,
                height: 50,
                isLoading: isLoading,
                text: 'បញ្ជូន',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
