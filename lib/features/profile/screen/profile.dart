import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app_sample/features/auth/screen/login_screen.dart';
import 'package:library_app_sample/features/auth/methods/auth_methods.dart';
import 'package:library_app_sample/features/profile/screen/editProfile.dart';
import 'package:library_app_sample/features/profile/widgets/rowwidget.dart';
import 'package:library_app_sample/features/saved/screen/saved_screen.dart';
import 'package:library_app_sample/main.dart';
import 'package:library_app_sample/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? data;
  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  void getUserDetail() async {
    // userModel =
    DocumentSnapshot snap = await AuthMethods().getUserDetail();
    data = snap;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Profile"
                    .text
                    .color(Colors.white)
                    .size(25)
                    .fontWeight(FontWeight.w800)
                    .make(),
                GestureDetector(
                  onTap: () {
                    theamNotifier.isDark
                        ? theamNotifier.isDark = false
                        : theamNotifier.isDark = true;
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: theamNotifier.isDark
                          ? const Icon(Icons.light_mode)
                          : const Icon(Icons.dark_mode)),
                ),
              ],
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: theamNotifier.isDark
                        ? [
                            const Color.fromARGB(255, 34, 34, 35),
                            const Color.fromARGB(255, 40, 40, 40)
                          ]
                        : [
                            Colors.blue,
                            const Color.fromARGB(255, 25, 109, 179)
                          ]),
              ),
            ),
          ),
          body: data == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : ListView(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: 320,
                      child: Stack(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 130,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: theamNotifier.isDark
                                      ? [
                                          const Color.fromARGB(255, 34, 34, 35),
                                          const Color.fromARGB(255, 40, 40, 40)
                                        ]
                                      : [
                                          Colors.blue,
                                          const Color.fromARGB(
                                              255, 25, 109, 179)
                                        ]),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                      radius: 80,
                                      backgroundColor: const Color.fromARGB(
                                          255, 156, 170, 177),
                                      backgroundImage: (data!.data()
                                                  as dynamic)['profileUrl'] ==
                                              ""
                                          ? const AssetImage(
                                              "asset/images/person.png")
                                          : NetworkImage((data!.data()
                                              as dynamic)['profileUrl']))
                                  .centered(),
                              const SizedBox(
                                height: 20,
                              ),
                              (data!.data() as dynamic)['userName']
                                  .toString()
                                  .text
                                  .bold
                                  .size(27)
                                  .color(theamNotifier.isDark
                                      ? Colors.white
                                      : Colors.black)
                                  .make(),
                              (data!.data() as dynamic)['email']
                                  .toString()
                                  .text
                                  .size(20)
                                  .color(theamNotifier.isDark
                                      ? Colors.white
                                      : Colors.black)
                                  .make()
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    const EditProfileScreen()))
                            .then((v) {
                          getUserDetail();
                        });
                      },
                      child: const ProfileRow(
                        icon: Icons.person_2_outlined,
                        text: "Edit Profile",
                      ),
                    ),
                    const ProfileRow(
                      icon: Icons.settings_outlined,
                      text: "Setting",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SavedScreen()));
                      },
                      child: const ProfileRow(
                        icon: Icons.bookmark_border,
                        text: "Saved",
                      ),
                    ),
                    const ProfileRow(
                      icon: Icons.info_outline,
                      text: "About us",
                    ),
                    GestureDetector(
                      onTap: () async {
                        await AuthMethods().logOutUser();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                        box1.put('isLogedIn', false);
                      },
                      child: const ProfileRow(
                        icon: Icons.exit_to_app_outlined,
                        text: "Log out",
                      ),
                    ),
                  ],
                ));
    });
  }
}
