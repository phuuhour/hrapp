import 'dart:convert';
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/work_manage.dart';
import 'package:http/http.dart' as http;
import 'package:hr/widget/customButton.dart';
import 'package:hr/widget/customTextField.dart';

class AddNewWork extends StatefulWidget {
  const AddNewWork({super.key});

  @override
  State<AddNewWork> createState() => _AddNewWorkState();
}

class _AddNewWorkState extends State<AddNewWork> {
  bool isLoading = false;
  TextEditingController sectionController = TextEditingController();
  TextEditingController nameWorkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Future<void> addWork(BuildContext context) async {
    if (sectionController.text.isEmpty ||
        nameWorkController.text.isEmpty ||
        salaryController.text.isEmpty ||
        dateController.text.isEmpty ||
        notesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("សូមបំពេញព័ត៌មានអោយបានពេញលេញ!"),
          backgroundColor: Colors.blue,
        ),
      );
      return;
    }

    // Validate payroll input (must be a number)
    if (double.tryParse(salaryController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("សូមបញ្ចូលចំនួនប្រាក់បៀវត្សរ៍ជាលេខ!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse('http://10.0.2.2/hr_api/addWork.php'); //API URL

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "section": sectionController.text,
          "name_work": nameWorkController.text,
          "date_create": dateController.text,
          "payroll": double.parse(
            salaryController.text,
          ), // Ensure number format
          "description": notesController.text,
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("ជោគជ័យ!"),
                content: const Text("ការងារបានបញ្ចូលដោយជោគជ័យ។"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Clear all text fields
                      setState(() {
                        sectionController.clear();
                        nameWorkController.clear();
                        dateController.clear();
                        salaryController.clear();
                        notesController.clear();
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WorkManage()),
                      );
                    },
                    child: const Text("បិទ"),
                  ),
                ],
              ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("មានបញ្ហាក្នុងការបញ្ចូលការងារ!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("កំហុសបណ្ដាញ: ${e.toString()}")));
    } finally {
      setState(() => isLoading = false);
    }
  }

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
              const SizedBox(height: 20),
              const Text(
                'ព័ត៌មានការងារ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const Divider(),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ផ្នែក',
                hint: '',
                icon: Boxicons.bx_shopping_bag,
                controller: sectionController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ឈ្មោះការងារ',
                hint: '',
                icon: Boxicons.bx_file,
                controller: nameWorkController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ថ្ងៃដំណើរការ',
                hint: 'DD/MM/YYYY',
                icon: Boxicons.bx_calendar,
                isDate: true,
                controller: dateController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'ចំនួនប្រាក់បៀវត្សរ៍',
                hint: '',
                icon: Boxicons.bx_money,
                controller: salaryController,
                keyboardType: TextInputType.number, // Restrict input to numbers
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'កំណត់ចំណាំ',
                hint: '',
                icon: Boxicons.bx_note,
                controller: notesController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: "បញ្ជូន",
                isLoading: isLoading,
                onPressed: () => addWork(context),
                isPrimary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
