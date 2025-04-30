import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr/screen/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'HRKH',
      theme: ThemeData(fontFamily: 'Kh Siemreap'),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}
