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
                      'https://scontent.fpnh11-1.fna.fbcdn.net/v/t39.30808-6/475308868_1150454489757657_4675051414966855150_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGoqGxxuSOm7JRBHicgzV2iJ5dpbjLjgoAnl2luMuOCgCFV8yLuLbqVMINGL6ZipNmoo9b2c_aGV3EZIkBgOjF-&_nc_ohc=8A7RoeGhDaMQ7kNvgE6_Rur&_nc_oc=AdimCXcR1fKdlVz_09d1sGx-ZMXjYtjuXjxNNJshYrag3vQbXNmzZ2Y49uMKfyJ3FyU&_nc_zt=23&_nc_ht=scontent.fpnh11-1.fna&_nc_gid=A5sq0U8Z2oy22w587Gyf3d0&oh=00_AYAcM_b3qf8PvfSwe77Zar2XcTswXjmOVvUGWeo4Hm0ZpA&oe=67CC8FE4',
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
