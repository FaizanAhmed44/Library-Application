import 'package:flutter/material.dart';
import 'package:library_app_sample/features/about/widget/aboutwidget.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "About"
                    .text
                    .color(Colors.white)
                    .size(25)
                    .fontWeight(FontWeight.w800)
                    .make(),
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
          body: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              HelpWidgetRowScreen(text: "About your account"),
              SizedBox(
                height: 25,
              ),
              HelpWidgetRowScreen(text: "Privacy policy"),
              SizedBox(
                height: 25,
              ),
              HelpWidgetRowScreen(text: "Terms of use"),
              SizedBox(
                height: 25,
              ),
              HelpWidgetRowScreen(text: "Open source liabraries"),
              SizedBox(
                height: 25,
              ),
              HelpWidgetRowScreen(text: "Security policy"),
              SizedBox(
                height: 25,
              ),
            ],
          ));
    });
  }
}
