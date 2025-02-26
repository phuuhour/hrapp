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
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Boxicons.bx_x, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
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
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ឈ្មោះពេញ',
                  hint: '',
                  icon: Boxicons.bx_user,
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
                CustomDropdownField(
                  label: 'ភេទ',
                  items: ['ប្រុស', 'ស្រី', 'ផ្សេងៗ'],
                  icon: Boxicons.bx_user_circle,
                  onChanged: (String? newValue) {},
                ),

                SizedBox(height: 10),
                CustomDropdownField(
                  label: 'ស្ថានភាពគ្រួសារ',
                  items: ['នៅលីវ', 'រៀបការហើយ', 'លែងលះ'],
                  icon: Boxicons.bx_heart,
                  onChanged: (String? newValue) {},
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
                  label: 'អាសយដ្ឋាន',
                  hint: '',
                  icon: Boxicons.bx_home,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'សញ្ជាតិ',
                  hint: '',
                  icon: Boxicons.bx_flag,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខអត្តសញ្ញាណប័ណ្ណ',
                  hint: '',
                  icon: Boxicons.bx_id_card,
                ),
                SizedBox(height: 20),
                Text(
                  'ព័ត៌មានអំពីមុខតំណែង',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'តួនាទី',
                  hint: '',
                  icon: Boxicons.bx_briefcase,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ផ្នែក',
                  hint: '',
                  icon: Boxicons.bx_network_chart,
                ),
                SizedBox(height: 10),
                CustomDropdownField(
                  label: 'ប្រភេទការងារ',
                  items: ['ពេញម៉ោង', 'ក្រៅម៉ោង', 'កិច្ចសន្យា'],
                  icon: Boxicons.bx_category,
                  onChanged: (String? newValue) {},
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ថ្ងៃចូលបំរើការងារ',
                  hint: 'DD/MM/YYYY',
                  icon: Boxicons.bx_calendar,
                  isDate: true,
                  controller: dateController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'បង្រៀនដោយ',
                  hint: '',
                  icon: Boxicons.bx_user_pin,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'ប្រាក់ខែ',
                  hint: '',
                  icon: Boxicons.bx_money,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខគណនីធនាគារ',
                  hint: '',
                  icon: Boxicons.bx_credit_card,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខទូរស័ព្ទការងារ',
                  hint: '',
                  icon: Boxicons.bx_phone,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'អ៊ីម៊ែលការងារ',
                  hint: '',
                  icon: Boxicons.bx_mail_send,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'អាសយដ្ឋានការងារ',
                  hint: '',
                  icon: Boxicons.bx_building,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'លេខអត្តសញ្ញាណប័ណ្ណការងារ',
                  hint: '',
                  icon: Boxicons.bx_id_card,
                ),
                SizedBox(height: 60),
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
