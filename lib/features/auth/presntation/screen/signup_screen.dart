import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app_sample/features/auth/presntation/screen/login_screen.dart';
import 'package:library_app_sample/features/bottm_navigation/screen/navigation_bar.dart';
import 'package:library_app_sample/main.dart';

import 'package:library_app_sample/features/auth/logic/providers/auth_methods.dart';

import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:library_app_sample/shared/widget/textField.dart';
import 'package:library_app_sample/shared/widget/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final List<String> imagesUrl = [
    'https://thumbs.dreamstime.com/b/computer-illustration-google-logo-isolated-white-background-google-logo-258534792.jpg',
  ];
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
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
                  height: 205,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        // begin: Alignment.topCenter,
                        // end: Alignment.bottomCenter,
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
                  child: "Create Your Account"
                      .text
                      .color(Colors.white)
                      .size(37)
                      .fontWeight(FontWeight.w800)
                      .make()
                      .centered()
                      .pOnly(bottom: 130),
                ),
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.12),
                  decoration: BoxDecoration(
                    color: theamNotifier.isDark ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(125),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      "Create your account so you can manage your personal information."
                          .text
                          .size(17)
                          .color(theamNotifier.isDark
                              ? Colors.white
                              : Colors.black)
                          .fontWeight(FontWeight.w600)
                          .make()
                          .pOnly(left: 55, right: 30),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.046,
                      ),
                      TextFieldInput(
                        controller: usernameController,
                        text: "Username",
                        icon: Icons.person_2_outlined,
                      ).px20(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      TextFieldInput(
                        controller: emailController,
                        text: "Email",
                        icon: Icons.email_outlined,
                      ).px20(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      TextFieldInput(
                        controller: passwordController,
                        text: "Password",
                        isPass: true,
                        icon: Icons.password_outlined,
                      ).px20(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          String res = await AuthMethods().signUpUser(
                              email: emailController.text,
                              password: passwordController.text,
                              username: usernameController.text);
                          if (res == 'success') {
                            emailController.clear();
                            passwordController.clear();
                            usernameController.clear();
                            showSnackBar("Successfully Login", context);
                            box1.put('isLogedIn', true);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavigationExample(),
                            ));
                          } else {
                            showSnackBar(res, context);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 58,
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
                              : "Sign up"
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
                      "Sign Up With"
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
                            backgroundImage: NetworkImage(imagesUrl[index]),
                          ).px8(),
                        );
                      })).centered(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen())),
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
                                  text: "  Login",
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
          ));
    });
  }
}
