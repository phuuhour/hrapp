import 'package:flutter/material.dart';
import 'package:hr/screen/loginScreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'HRKH',
      theme: ThemeData(fontFamily: 'Khmer OS Content'),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}
