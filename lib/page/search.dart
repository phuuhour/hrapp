// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Searchpage extends StatelessWidget {
  final TextEditingController _searchcontroller = TextEditingController();

  Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        elevation: 0,
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: Icon(Icons.close, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              TextField(
                controller: _searchcontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.15),
                  hintText: 'ស្វែងរកទាំងអស់...',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(child: Center(child: Text('មិនមានទិន្នន័យ'))),
            ],
          ),
        ),
      ),
    );
  }
}
