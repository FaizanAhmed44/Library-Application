import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app_sample/features/auth/logic/providers/auth_methods.dart';
import 'package:library_app_sample/features/profile/method/userMethod.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:library_app_sample/shared/widget/utils/utils.dart';

import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  Uint8List? image;
  bool isLoading = false;
  DocumentSnapshot? user;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  void getUserDetail() async {
    // userModel =
    DocumentSnapshot snap = await AuthMethods().getUserDetail();
    user = snap;
    setState(() {});
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: "Edit profile"
              .text
              .color(theamNotifier.isDark ? Colors.white : Colors.black)
              .make(),
          centerTitle: false,
          actions: [
            image != null
                ? GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await UserMethods().updateUser(
                          file: image!,
                          uid: FirebaseAuth.instance.currentUser!.uid);

                      image = null;
                      getUserDetail();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Icon(
                      Icons.done,
                      color: Colors.blue,
                      size: 30,
                    ).px16(),
                  )
                : Container(),
            (bioController.text.isNotEmpty ||
                    nameController.text.isNotEmpty ||
                    ageController.text.isNotEmpty ||
                    maritalStatusController.text.isNotEmpty)
                ? GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (bioController.text.isEmpty) {
                        bioController.text = (user!.data() as dynamic)['bio'];
                      }
                      if (nameController.text.isEmpty) {
                        nameController.text =
                            (user!.data() as dynamic)['userName'];
                      }
                      if (ageController.text.isEmpty) {
                        ageController.text = (user!.data() as dynamic)['age'];
                      }
                      if (maritalStatusController.text.isEmpty) {
                        maritalStatusController.text =
                            (user!.data() as dynamic)['martialStatus'];
                      }
                      await UserMethods().updateUserInfo(
                        age: ageController.text,
                        bio: bioController.text,
                        martialStatus: maritalStatusController.text,
                        name: nameController.text,
                        uid: FirebaseAuth.instance.currentUser!.uid,
                      );
                      getUserDetail();

                      setState(() {
                        isLoading = false;
                        bioController.text = '';
                        nameController.text = '';
                        ageController.text = '';
                        maritalStatusController.text = '';
                      });
                    },
                    child: const Icon(
                      Icons.done,
                      color: Colors.blue,
                      size: 30,
                    )).px16()
                : Container(),
          ],
        ),
        body: user == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading ? const LinearProgressIndicator() : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: image == null
                            ? (user!.data() as dynamic)['profileUrl'] == ""
                                ? const AssetImage("asset/images/profile.png")
                                : NetworkImage(
                                    (user!.data() as dynamic)['profileUrl'])
                            : MemoryImage(image!),
                        radius: 55,
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: "Edit profile picture"
                          .text
                          .color(Colors.blue)
                          .size(17)
                          .makeCentered(),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    "Username"
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .size(15)
                        .make()
                        .px16(),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(
                          color: theamNotifier.isDark
                              ? const Color.fromARGB(132, 255, 255, 255)
                              : Colors.black),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: theamNotifier.isDark
                                ? const Color.fromARGB(132, 255, 255, 255)
                                : Colors.black),
                        // hintText: user.username,
                        hintText: (user!.data() as dynamic)['userName'],
                      ),
                      onFieldSubmitted: (val) {
                        setState(() {});
                      },
                    ).px16(),
                    const SizedBox(
                      height: 30,
                    ),
                    "Bio"
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .size(15)
                        .make()
                        .px16(),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      controller: bioController,
                      style: TextStyle(
                          color: theamNotifier.isDark
                              ? const Color.fromARGB(132, 255, 255, 255)
                              : Colors.black),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: theamNotifier.isDark
                                ? const Color.fromARGB(132, 255, 255, 255)
                                : Colors.black),
                        // hintText: user.bio,
                        hintText: (user!.data() as dynamic)['bio'] == ""
                            ? "bio"
                            : (user!.data() as dynamic)['bio'],
                      ),
                      onFieldSubmitted: (val) {
                        setState(() {});
                      },
                    ).px16(),
                    const SizedBox(
                      height: 36,
                    ),
                    "Email"
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .size(15)
                        .make()
                        .px16(),
                    const SizedBox(
                      height: 7,
                    ),
                    (user!.data() as dynamic)['email']
                        .toString()
                        .text
                        .color(theamNotifier.isDark
                            ? const Color.fromARGB(132, 255, 255, 255)
                            : Colors.black)
                        .size(18)
                        .make()
                        .px16(),
                    const Divider(
                      color: Colors.grey,
                    ).px16(),
                    const SizedBox(
                      height: 27,
                    ),
                    "Age"
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .size(15)
                        .make()
                        .px16(),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      controller: ageController,
                      style: TextStyle(
                          color: theamNotifier.isDark
                              ? const Color.fromARGB(132, 255, 255, 255)
                              : Colors.black),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: theamNotifier.isDark
                                ? const Color.fromARGB(132, 255, 255, 255)
                                : Colors.black),
                        // hintText: user.bio,
                        hintText: (user!.data() as dynamic)['age'] == ""
                            ? "e.g   (20, 15, 21)"
                            : (user!.data() as dynamic)['age'],
                      ),
                      onFieldSubmitted: (val) {
                        setState(() {});
                      },
                    ).px16(),
                    const SizedBox(
                      height: 30,
                    ),
                    "Marital Status"
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .size(15)
                        .make()
                        .px16(),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      controller: maritalStatusController,
                      style: TextStyle(
                          color: theamNotifier.isDark
                              ? const Color.fromARGB(132, 255, 255, 255)
                              : Colors.black),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: theamNotifier.isDark
                                ? const Color.fromARGB(132, 255, 255, 255)
                                : Colors.black),
                        // hintText: user.bio,
                        hintText:
                            (user!.data() as dynamic)['martialStatus'] == ""
                                ? "Single"
                                : (user!.data() as dynamic)['martialStatus'],
                      ),
                      onFieldSubmitted: (val) {
                        setState(() {});
                      },
                    ).px16(),
                  ],
                ),
              ),
      );
    });
  }
}
