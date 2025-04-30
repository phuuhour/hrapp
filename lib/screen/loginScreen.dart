// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:hr/widget/Button.dart';
import 'package:hr/widget/TextField.dart';
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
                  'ចូលគណនីរបស់អ្នក',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                CustomTextField(
                  label: "លេខទូរស័ព្ទ",
                  icon: Icon(Boxicons.bxs_phone),
                  lendingIcon: false,
                  hint: '',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: "ពាក្យសម្ងាត់",
                  isPassword: true,
                  hint: '',
                  icon: Icon(Boxicons.bxs_lock),
                  lendingIcon: false,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 60),
                CustomButton(
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  isLoading: isLoading,
                  text: 'ចូលគណនី',
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(Duration(seconds: 0), () {
                      setState(() {
                        isLoading = false;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
