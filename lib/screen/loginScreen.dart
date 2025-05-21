// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously

import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr/model/adminaccount.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:hr/widget/Button.dart';
import 'package:hr/widget/TextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('ព្យាយាមម្ដងទៀត', style: TextStyle(fontSize: 18)),
            content: Text(message),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'យល់ព្រម',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
            child: Column(
              children: [
                Image.asset('assets/icons/login.png', height: 150),
                SizedBox(height: 20),
                Text(
                  'ចូលគណនី',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 45),
                CustomTextField(
                  label: "លេខទូរស័ព្ទ",
                  icon: Icon(Boxicons.bxs_phone),
                  lendingIcon: false,
                  hint: 'លេខទូរស័ព្ទ',
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: "ពាក្យសម្ងាត់",
                  isPassword: true,
                  hint: 'ពាក្យសម្ងាត់',
                  icon: Icon(Boxicons.bxs_lock),
                  lendingIcon: false,
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                ),

                SizedBox(height: 65),
                CustomButton(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 50,
                  isLoading: isLoading,
                  text: 'ចូលគណនី',
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final phone = phoneController.text.trim();
                    final password = passwordController.text.trim();

                    if (phone.isEmpty || password.isEmpty) {
                      setState(() {
                        isLoading = false;
                      });
                      showErrorDialog(
                        context,
                        'សូមបំពេញលេខទូរស័ព្ទ និងពាក្យសម្ងាត់',
                      );
                      return;
                    }

                    try {
                      final querySnapshot =
                          await FirebaseFirestore.instance
                              .collection('adminacc')
                              .where('phone', isEqualTo: phone)
                              .where('password', isEqualTo: password)
                              .limit(1)
                              .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        final adminData = AdminAccount.fromMap(
                          querySnapshot.docs.first.data(),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder:
                                (context) => DashboardScreen(admin: adminData),
                          ),
                        );
                      } else {
                        showErrorDialog(
                          context,
                          'លេខទូរស័ព្ទ ឬ ពាក្យសម្ងាត់មិនត្រឹមត្រូវទេ។',
                        );
                      }
                    } catch (e) {
                      showErrorDialog(
                        context,
                        'កំហុសក្នុងការតភ្ជាប់។ សូមព្យាយាមម្តងទៀត។',
                      );
                    } finally {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
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
