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
      backgroundColor: Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black45, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.sectionTitle, style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        FutureBuilder<QuerySnapshot>(
                          future:
                              FirebaseFirestore.instance
                                  .collection('works')
                                  .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  height: 35,
                                  width: 50,
                                  child: Center(
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('មានបញ្ហាក្នុងការទាញយកទិន្នន័យ'),
                              );
                            } else {
                              final works = snapshot.data?.docs ?? [];

                              final filteredWorks =
                                  works.where((work) {
                                    final data =
                                        work.data() as Map<String, dynamic>;
                                    return data['section'] ==
                                        widget.sectionTitle;
                                  }).toList();

                              if (filteredWorks.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'គ្មានការងារនៅក្នុងផ្នែកនេះទេ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              }

                              return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children:
                                    filteredWorks.map((work) {
                                      final data =
                                          work.data() as Map<String, dynamic>;
                                      final workName =
                                          data['workName'] ?? 'Unknown';

                                      return ListTile(
                                        contentPadding: EdgeInsets.only(
                                          left: 0,
                                        ),
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
                                            PageRouteBuilder(
                                              pageBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) => DetailWork(
                                                    workData: data,
                                                    workId: work.id,
                                                  ),
                                              transitionsBuilder: (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                                child,
                                              ) {
                                                const begin = Offset(1.0, 0.0);
                                                const end = Offset.zero;
                                                const curve = Curves.easeInOut;

                                                var tween = Tween(
                                                  begin: begin,
                                                  end: end,
                                                ).chain(
                                                  CurveTween(curve: curve),
                                                );
                                                return SlideTransition(
                                                  position: animation.drive(
                                                    tween,
                                                  ),
                                                  child: child,
                                                );
                                              },
                                              transitionDuration: Duration(
                                                milliseconds: 300,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
