import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/widget/customListTIle.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('ព័ត៌មានរបស់ខ្ញុំ', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/b2/1e/d9/b21ed98a5eb1d86a1dd633eb2ef59522.jpg',
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 192, 230, 255),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Boxicons.bxs_edit, color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              CustomListTile(
                icon: Boxicons.bx_detail,
                title: "ឈ្មោះ",
                subtitle: "តារា វង្ស",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_phone,
                title: "លេខទូរស័ព្ទ",
                subtitle: "014789632",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_shopping_bag,
                title: "ប្រភេទការងារ និងមុខតំណែង",
                subtitle: "HR, CEO",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_dollar_circle,
                title: "ប្រាក់ខែ",
                subtitle: "\$1200",
                onPressed: () {},
              ),
              Divider(indent: 67, height: 0, thickness: 0.6),
              CustomListTile(
                icon: Boxicons.bxs_calendar,
                title: "ថ្ងៃខែចូលធ្វើការ",
                subtitle: "12-02-2021",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
