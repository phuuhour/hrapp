import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:hr/widget/customButton.dart';
import 'package:hr/widget/customTextField.dart';
import 'package:hugeicons/hugeicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var isLoading = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: const Color.fromARGB(255, 192, 230, 255),
                  child: Icon(
                    HugeIcons.strokeRoundedLoginMethod,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ចូលប្រើ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "លេខទូរស័ព្ទ",
                  icon: Boxicons.bxs_phone,
                  hint: '',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: "ពាក្យសម្ងាត់",
                  icon: Boxicons.bxs_lock,
                  isPassword: true,
                  hint: '',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 60),
                CustomButton(
                  text: "ចូលគណនី",
                  isLoading: isLoading,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.pushReplacement(
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
