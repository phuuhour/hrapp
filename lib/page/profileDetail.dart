import 'dart:io';
import 'package:boxicons/boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:HR/model/adminaccount.dart';
import 'package:HR/screen/loginScreen.dart';
import 'package:HR/service/image_upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'member.dart';

class ProfileDetail extends StatefulWidget {
  final AdminAccount admin;

  const ProfileDetail({super.key, required this.admin});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  int? memberCount;
  XFile? _pickedImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    fetchMemberCount();
  }

  Future<void> fetchMemberCount() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('employees')
              .where('adminname', isEqualTo: widget.admin.fullname)
              .get();

      setState(() {
        memberCount = querySnapshot.size;
      });
    } catch (e) {
      setState(() {
        memberCount = 0;
      });
    }
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> handleImageUpload() async {
    final picked = await pickImage();
    if (picked == null) return;

    setState(() {
      _pickedImage = picked;
      _isUploading = true;
    });

    try {
      final file = File(picked.path);

      // Step 1: Delete old image from Firebase Storage
      final oldImageUrl = widget.admin.imgUrl;
      if (oldImageUrl.isNotEmpty) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(oldImageUrl);
          await ref.delete();
        } catch (e) {
          debugPrint('Failed to delete old image: $e');
        }
      }

      // Step 2: Upload new image
      final imageUrl = await ImageUploadService.uploadImage(file);
      if (imageUrl == null) throw Exception("New image upload failed.");

      // Step 3: Update Firestore with new imageUrl
      final query =
          await FirebaseFirestore.instance
              .collection('adminacc')
              .where('phone', isEqualTo: widget.admin.phone)
              .limit(1)
              .get();

      if (query.docs.isNotEmpty) {
        final docId = query.docs.first.id;

        await FirebaseFirestore.instance
            .collection('adminacc')
            .doc(docId)
            .update({'imgUrl': imageUrl});

        setState(() {
          widget.admin.imgUrl = imageUrl;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'រួចរាល់',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Admin document not found.');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('បរាជ័យ: ${e.toString()}')));
      }
      debugPrint('Error updating profile image: $e');
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  ImageProvider _getProfileImage() {
    if (_pickedImage != null) {
      return FileImage(File(_pickedImage!.path));
    } else if (widget.admin.imgUrl.isNotEmpty) {
      return NetworkImage(widget.admin.imgUrl);
    } else {
      return const AssetImage('assets/images/avatar.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black45,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('គណនីរបស់ខ្ញុំ', style: TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _getProfileImage(),
                        ),
                        if (_isUploading)
                          Positioned(
                            left: 50,
                            bottom: 5,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.greenAccent,
                                ),
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: handleImageUpload,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                              ),
                              child: const Icon(
                                Boxicons.bxs_camera,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.admin.fullname,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.admin.phone,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () async {
                            try {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              // Clear ALL stored data including remember me credentials
                              await prefs.clear();

                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'បរាជ័យក្នុងការចេញ: ${e.toString()}',
                                  ),
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'ចាកចេញ',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'សមាជិកក្រុម',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle:
                          memberCount == null
                              ? const Text(
                                'កំពុងទាញយក...',
                                style: TextStyle(fontSize: 15),
                              )
                              : Text(
                                '$memberCount នាក់',
                                style: const TextStyle(fontSize: 15),
                              ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 20,
                        color: Colors.black45,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Member(adminName: widget.admin.fullname),
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
                              ).chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                              milliseconds: 300,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
