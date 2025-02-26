import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/detail_work.dart';
import 'package:hr/widget/customListTIle.dart';
import 'package:hr/widget/showdialog.dart';

class PayrollbyWork extends StatelessWidget {
  const PayrollbyWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ប្រាក់ខែសរុប (ការងារ)', style: TextStyle(fontSize: 18)),
        centerTitle: true,
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
                icon: Boxicons.bx_network_chart,
                title: 'Network Engineer',
                subtitle: '\$1200',
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => DetailWork()),
                  );
                },
              ),
              CustomListTile(
                icon: Boxicons.bxl_javascript,
                title: 'Javascript Developer',
                subtitle: '\$1200',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
