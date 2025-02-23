import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/widget/customListTIle.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('សាជូនដំណឹង', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomListTile(
            icon: Icons.notifications,
            title: 'ថ្ងៃឈប់សម្រាក',
            subtitle: 'ចំនួន ៣ថ្ងៃ ចាប់ពីទី ២៨ ខែដល់ ៩ខែ៣',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
