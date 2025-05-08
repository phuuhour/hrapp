import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailWork extends StatefulWidget {
  const DetailWork({super.key, required this.workData});

  final Map<String, dynamic> workData;

  @override
  State<DetailWork> createState() => _DetailWorkState();
}

class _DetailWorkState extends State<DetailWork> {
  void deleteWorkById(String workId) {
    FirebaseFirestore.instance
        .collection('works')
        .where('workId', isEqualTo: workId)
        .get()
        .then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            doc.reference.delete();
          }
        })
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('km', null);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.workData['workName'] ?? 'ព័ត៌មានការងារ',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'លុបការងារ',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    content: Text('តើអ្នកប្រាកដទេ?'),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'មិនធ្វើ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteWorkById(widget.workData['workId']);
                          setState(() {});
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('ការងារត្រូវបានលុប!'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'លុប',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Boxicons.bxs_trash, color: Colors.white, size: 20),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              ListTile(
                title: Text('លេខសម្គាល់ការងារ'),
                trailing: Text(
                  widget.workData['workId'] ?? '-',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title: Text('ផ្នែក'),
                trailing: Text(
                  widget.workData['section'] ?? '-',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title: Text('ឈ្មោះការងារ'),
                trailing: Text(
                  widget.workData['workName'] ?? '-',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title: Text('ថ្ងៃចាប់ផ្តើម'),
                trailing: Text(
                  widget.workData['date'] != null
                      ? ' ${DateFormat('dd MMM yyyy', 'km').format(DateTime.parse(widget.workData['date']))}'
                      : '-',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title: Text('ទីតាំងការងារ(សាខា)'),
                trailing: Text(
                  widget.workData['branch'] ?? '-',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title: Text('ប្រាក់បៀវត្ស'),
                trailing: Text(
                  widget.workData['payroll'] != null
                      ? '\$${widget.workData['payroll'].toStringAsFixed(2)}'
                      : '-',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
