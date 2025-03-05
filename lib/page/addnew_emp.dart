import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:hr/widget/customButton.dart';
import 'package:hr/widget/customDropdownField.dart';
import 'package:hr/widget/customTextField.dart';

class AddnewEmp extends StatefulWidget {
  const AddnewEmp({super.key});

  @override
  State<AddnewEmp> createState() => _AddnewEmpState();
}

class _AddnewEmpState extends State<AddnewEmp> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    TextEditingController dateController = TextEditingController();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'ព័ត៌មានបុគ្គលិក',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Divider(),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខសម្គាល់បុគ្គលិក',
                  hint: '',
                  icon: Boxicons.bx_id_card,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ឈ្មោះពេញ',
                  hint: '',
                  icon: Boxicons.bx_user,
                ),
                SizedBox(height: 10),
                CustomDropdownField(
                  label: 'ភេទ',
                  items: ['ប្រុស', 'ស្រី'],
                  icon: Boxicons.bx_user_circle,
                  onChanged: (String? newValue) {},
                ),

                SizedBox(height: 10),
                CustomTextField(
                  label: 'ថ្ងៃខែឆ្នាំកំណើត',
                  hint: 'DD/MM/YYYY',
                  icon: Boxicons.bx_calendar,
                  isDate: true,
                  controller: dateController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខទូរស័ព្ទ',
                  hint: '',
                  icon: Boxicons.bx_phone,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'អ៊ីម៊ែល',
                  hint: '',
                  icon: Boxicons.bx_message_detail,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខអត្តសញ្ញាណប័ណ្ណ',
                  hint: '',
                  icon: Boxicons.bx_id_card,
                ),
                SizedBox(height: 10),
                CustomDropdownField(
                  label: 'ប្រភេទបុគ្គលិក',
                  items: ['ពេញម៉ោង', 'ក្រៅម៉ោង', 'កិច្ចសន្យា'],
                  icon: Boxicons.bx_category,
                  onChanged: (String? newValue) {},
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'អាសយដ្ឋាន',
                  hint: '',
                  icon: Boxicons.bx_home,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ថ្ងៃចូលបំរើការងារ',
                  hint: 'DD/MM/YYYY',
                  icon: Boxicons.bx_calendar,
                  isDate: true,
                  controller: dateController,
                ),

                SizedBox(height: 20),

                Text(
                  'ព័ត៌មានការងារ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Divider(),
                SizedBox(height: 10),
                CustomDropdownField(
                  label: 'ផ្នែក',
                  items: ['IT', 'SERVICE', 'ACCOUNT'],
                  icon: Boxicons.bx_category,
                  onChanged: (String? newValue) {},
                ),

                SizedBox(height: 10),

                CustomDropdownField(
                  label: 'ការងារ',
                  items: ['NETWORK', 'PROGRAMMING', 'SOFTWARE', 'HARDWARE'],
                  icon: Boxicons.bx_category,
                  onChanged: (String? newValue) {},
                ),
                SizedBox(height: 20),

                Text(
                  'មធ្យោបាយបើកប្រាក់ខែ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Divider(),
                SizedBox(height: 10),
                CustomDropdownField(
                  label: 'ធនាគារ',
                  items: ['ABA', 'ACLEDA', 'KBPRASAC'],
                  icon: Boxicons.bx_category,
                  onChanged: (String? newValue) {},
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ឈ្មោះគណនី',
                  hint: '',
                  icon: Boxicons.bx_credit_card,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខគណនី',
                  hint: '',
                  icon: Boxicons.bx_credit_card_front,
                ),
                SizedBox(height: 20),

                Text(
                  'ប្រាក់ខែ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Divider(),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ប្រាក់ខែគោល',
                  hint: '',
                  icon: Boxicons.bx_money,
                ),

                SizedBox(height: 40),
                CustomButton(
                  text: "បញ្ជូន",
                  isLoading: isLoading,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
