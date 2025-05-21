import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr/page/detail_work.dart';

class ListWork extends StatefulWidget {
  const ListWork({super.key, required this.sectionTitle});

  final String sectionTitle;

  @override
  State<ListWork> createState() => _ListWorkState();
}

class _ListWorkState extends State<ListWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.sectionTitle,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white, size: 20),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('works').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'));
              } else {
                final works = snapshot.data?.docs ?? [];

                // Filter works by selected section
                final filteredWorks =
                    works.where((work) {
                      final data = work.data() as Map<String, dynamic>;
                      return data['section'] == widget.sectionTitle;
                    }).toList();

                if (filteredWorks.isEmpty) {
                  return Center(child: Text('គ្មានការងារនៅក្នុងផ្នែកនេះទេ'));
                }

                return ListView(
                  children:
                      filteredWorks.map((work) {
                        final data = work.data() as Map<String, dynamic>;
                        final workName = data['workName'] ?? 'Unknown';

                        return ListTile(
                          contentPadding: EdgeInsets.only(left: 0),
                          title: Text(workName),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.black45,
                          ),
                          subtitle: Text(
                            '${data['branch'] ?? ''}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder:
                                    (context) => DetailWork(workData: data),
                              ),
                            );
                          },
                        );
                      }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
