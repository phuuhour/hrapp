import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);

    final TextEditingController _fullname = TextEditingController();
    final TextEditingController _phone = TextEditingController();
    final TextEditingController _password = TextEditingController();
    var isLoading = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
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
              items: const [],
              hint: '',
              icon: Icons.arrow_drop_down,
              controller: _fullname,
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            CustomDropdownList(
              label: 'លេខទូរស័ព្ទ',
              items: const [],
              hint: '',
              icon: Icons.arrow_drop_down,
              controller: _phone,
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "ពាក្យសម្ងាត់ថ្មី",
              isPassword: true,
              hint: '',
              icon: Icon(Boxicons.bxs_lock),
              lendingIcon: false,
              keyboardType: TextInputType.text,
              controller: _password,
            ),
            SizedBox(height: 60),
            CustomButton(
              color: Colors.teal,
              width: MediaQuery.of(context).size.width,
              height: 50,
              isLoading: isLoading,
              text: 'បង្កើតគណនី',
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
