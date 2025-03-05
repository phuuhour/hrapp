import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/detail_emp.dart';
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/widget/showdialog.dart';

class Payrollbyemp extends StatelessWidget {
  const Payrollbyemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ប្រាក់ខែសរុប (បុគ្គលិក)', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              CustomButton(
                onPressed: () {},
                text: 'ទឹកប្រាក់សរុបៈ \$2500',
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              CustomListTile(
                icon: Icons.person,
                title: 'រិន សុដា',
                subtitle: '\$1200',
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => DetailEmp()),
                  );
                },
              ),
              CustomListTile(
                icon: Icons.person,
                title: 'ហៀង បុរី',
                subtitle: '\$2000',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
