import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:hr/widget/customButton.dart' as btn;
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/widget/showdialog.dart';

class DetailEmp extends StatelessWidget {
  const DetailEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Boxicons.bx_x, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://scontent.fpnh11-1.fna.fbcdn.net/v/t39.30808-6/480360307_1164277348375371_4858218047620340990_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeH2xAN6RdCsWLoeCjV2zhK1h557Q449rAaHnntDjj2sBmuu9bRlI7Zwu7SySeMn7xl99fIaBd1s0mYK1IKs3zE_&_nc_ohc=_kmbLgJkRwUQ7kNvgEPPT3B&_nc_oc=AdgVkzj7FEC3Y4qtkTR_xA68QAZfb0_XpuIHLJM4Qyd_XmmCzZfAn3JSORP-Kju-7KI&_nc_zt=23&_nc_ht=scontent.fpnh11-1.fna&_nc_gid=AHONHF374XvluRNs04OVpcI&oh=00_AYAHx0OQoFlByhcmlS5x-PjTOv3m1bjiKHSUS6dz0NWWuw&oe=67BCCC3A',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "រិន សុដា",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      GestureDetector(
                        child: Text('Network Engineer'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("ព័ត៌មានបុគ្គលិក", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),

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
                subtitle: "Network Engineer, Manager",
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
              SizedBox(height: 20),
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
    );
  }
}
