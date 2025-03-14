import 'package:flutter/material.dart';
import 'package:hr/widget/customButton.dart' as btn;
import 'package:hr/widget/showdialog.dart';

class DetailEmp extends StatelessWidget {
  const DetailEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ព័ត៌មានបុគ្គលិក', style: TextStyle(fontSize: 18)),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black45),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: 250,
                    image: NetworkImage(
                      'https://i.pinimg.com/736x/e5/fb/97/e5fb973e3af8bfc788ac4966eaedad21.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 10),

                SizedBox(height: 40),
                btn.CustomButton(
                  text: 'មានអ្វីមួយមិនប្រក្រតី',
                  onPressed: () {
                    showCustomOptionDialog(context);
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
