import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app_sample/features/bottm_navigation/screen/navigation_bar.dart';
import 'package:library_app_sample/features/home/home_screen.dart';
import 'package:library_app_sample/main.dart';
import 'package:library_app_sample/features/auth/logic/providers/auth_methods.dart';
import 'package:library_app_sample/features/auth/presntation/screen/signup_screen.dart';

import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:library_app_sample/shared/widget/textField.dart';
import 'package:library_app_sample/shared/widget/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<String> imagesUrl = [
    'asset/images/google.png',
  ];
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
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
          body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 250,
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
                  child: "Welcome Back!"
                      .text
                      .color(Colors.white)
                      .size(38)
                      .fontWeight(FontWeight.w800)
                      .make()
                      .centered()
                      .pOnly(bottom: 132),
                ),
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(125),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      "Unlock a world of knowledge with your login."
                          .text
                          .size(17)
                          .color(Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .fontWeight(FontWeight.w600)
                          .make()
                          .pOnly(left: 37, right: 16),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      TextFieldInput(
                        controller: emailController,
                        text: "Email",
                        icon: Icons.email_outlined,
                      ).px20(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      TextFieldInput(
                        controller: passwordController,
                        text: "Password",
                        isPass: true,
                        icon: Icons.password_outlined,
                      ).px20(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          String res = await AuthMethods().logInUser(
                              email: emailController.text,
                              password: passwordController.text);
                          if (res == 'success') {
                            emailController.clear();
                            passwordController.clear();
                            showSnackBar("Successfully Login", context);
                            box1.put('isLogedIn', true);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigationExample()));
                          } else {
                            showSnackBar(res, context);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue,
                                Color.fromARGB(255, 25, 109, 179)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : "Log in"
                                  .text
                                  .color(Colors.white)
                                  .size(19.6)
                                  .bold
                                  .make()
                                  .centered(),
                        ).px20(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      "Login with"
                          .text
                          .color(theamNotifier.isDark
                              ? Colors.white
                              : const Color.fromARGB(255, 46, 113, 228))
                          .size(15)
                          .bold
                          .make()
                          .centered(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Wrap(
                          children: List.generate(imagesUrl.length, (index) {
                        return GestureDetector(
                          onTap: () async {
                            User? user = await AuthService().signInWithGoogle();
                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Google Sign-In successful!")),
                              );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigationExample()));
                              box1.put('isLogedIn', true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Google Sign-In failed")),
                              );
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 24,
                            backgroundImage: AssetImage(imagesUrl[index]),
                          ).px8(),
                        );
                      })).centered(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen())),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                                color: theamNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15.7),
                            children: [
                              TextSpan(
                                  text: "  Sign Up",
                                  style: TextStyle(
                                      color: theamNotifier.isDark
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 46, 113, 228),
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ).centered(),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          )

          // ListView(
          //   shrinkWrap: true,
          //   children: [
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.09,
          //     ),
          //     const Text(
          //       "Welcome!",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 32,
          //       ),
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.01,
          //     ),
          //     "Unlock a world of knowledge with your login."
          //         .text
          //         .color(Colors.grey)
          //         .size(19)
          //         .make(),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.09,
          //     ),
          //     TextFieldInput(controller: emailController, text: "Email"),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.04,
          //     ),
          //     TextFieldInput(controller: passwordController, text: "Password"),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.04,
          //     ),
          //     Container(
          //       width: double.maxFinite,
          //       height: 60,
          //       decoration: BoxDecoration(
          //         color: Colors.blueAccent,
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       child: "Sign in"
          //           .text
          //           .color(Colors.white)
          //           .size(19.6)
          //           .bold
          //           .make()
          //           .centered(),
          //     ),
          //   ],
          // ).px16(),
          );
    });
  }
}
