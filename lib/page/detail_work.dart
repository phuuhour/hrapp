import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/model/work.dart'; // Import the Work model

class DetailWork extends StatelessWidget {
  final Work work; // Add a Work parameter

  const DetailWork({super.key, required this.work}); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ព័ត៌មានការងារ', style: TextStyle(fontSize: 18)),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black45),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                icon: Boxicons.bx_shopping_bag,
                title: "ផ្នែក",
                subtitle: work.section,
                onPressed: () {},
              ),
              CustomListTile(
                icon: Boxicons.bx_file,
                title: "ឈ្មោះការងារ",
                subtitle: work.nameWork,
                onPressed: () {},
              ),
              CustomListTile(
                icon: Boxicons.bx_calendar,
                title: "ថ្ងៃដំណើរការ",
                subtitle: work.dateCreate,
                onPressed: () {},
              ),
              CustomListTile(
                icon: Boxicons.bx_money,
                title: "ចំនួនប្រាក់បៀវត្ស",
                subtitle: '\$${work.payroll.toStringAsFixed(2)}',
                onPressed: () {},
              ),
              CustomListTile(
                icon: Boxicons.bx_note,
                title: "កំណត់ចំណាំ",
                subtitle: work.description,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
