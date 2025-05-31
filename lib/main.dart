import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/dashboradScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hr/screen/loginScreen.dart';
import 'package:hr/model/adminaccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check login status
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final rememberMe = prefs.getBool('rememberMe') ?? false;

  runApp(
    MaterialApp(
      title: 'HRKH',
      theme: ThemeData(fontFamily: 'Kh Siemreap'),
      debugShowCheckedModeBanner: false,
      home:
          isLoggedIn && rememberMe
              ? FutureBuilder<AdminAccount?>(
                future: _getAdminData(prefs),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: Text(
                          'កំពុងចូលប្រើ...',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return DashboardScreen(admin: snapshot.data!);
                  }
                  return const LoginScreen();
                },
              )
              : const LoginScreen(),
    ),
  );
}

Future<AdminAccount?> _getAdminData(SharedPreferences prefs) async {
  try {
    final phone = prefs.getString('adminPhone');
    if (phone == null) return null;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('adminacc')
            .where('phone', isEqualTo: phone)
            .limit(1)
            .get();

    if (snapshot.docs.isNotEmpty) {
      return AdminAccount.fromMap(snapshot.docs.first.data());
    }
    return null;
  } catch (e) {
    return null;
  }
}
