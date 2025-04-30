import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';

class DetailEmp extends StatelessWidget {
  const DetailEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ព័ត៌មានបុគ្គលិក',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Boxicons.bxs_edit_alt, color: Colors.white, size: 20),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Boxicons.bxs_trash, color: Colors.white, size: 20),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
                height: 250,
                width: 250,
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
                childrenPadding: EdgeInsets.symmetric(horizontal: 15),
                tilePadding: EdgeInsets.symmetric(horizontal: 15),
                shape: Border(),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("លេខសម្គាល់បុគ្គលិក"),
                    trailing: Text('MP001', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ឈ្មោះពេញ"),
                    trailing: Text(
                      'លី វ៉េងហួរ',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ភេទ"),
                    trailing: Text('ប្រុស', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ថ្ងៃខែឆ្នាំកំណើត"),
                    trailing: Text(
                      '14/02/2004',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("លេខទូរស័ព្ទ"),
                    trailing: Text(
                      '096 218 2300',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("អ៊ីមែល"),
                    trailing: Text(
                      'lyvenghour@gmail.com',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("លេខអត្តសញ្ញាណប័ណ្ណ"),
                    trailing: Text('14453679', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ប្រភេទបុគ្គលិក"),
                    trailing: Text(
                      'កិច្ចសន្យា',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("អាសយដ្ឋាន"),
                    trailing: Text('ភ្នំពេញ', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ថ្ងៃចូលបម្រើការងារ"),
                    trailing: Text(
                      '02/01/2020',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: Text('ព័ត៌មានការងារ'),
                tilePadding: EdgeInsets.symmetric(horizontal: 15),
                childrenPadding: EdgeInsets.symmetric(horizontal: 15),
                shape: Border(),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ផ្នែក"),
                    trailing: Text('IT', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ការងារ"),
                    trailing: Text(
                      'Mobile Programming',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ធនាគារ"),
                    trailing: Text('ABA', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ឈ្មោះគណនី"),
                    trailing: Text(
                      'LY VENG HOUR',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("លេខគណនី"),
                    trailing: Text('3369987', style: TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text("ប្រាក់ខែ"),
                    trailing: Text('\$1500', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
