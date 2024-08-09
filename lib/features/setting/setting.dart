import 'package:flutter/material.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountModeScreen extends StatefulWidget {
  const AccountModeScreen({super.key});

  @override
  State<AccountModeScreen> createState() => _AccountModeScreenState();
}

class _AccountModeScreenState extends State<AccountModeScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Setting"
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
          body: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Light/Dark mode"
                      .text
                      .bold
                      .size(21)
                      .color(theamNotifier.isDark ? Colors.white : Colors.black)
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
              ).px16(),
              const SizedBox(
                height: 29,
              ),
              "Light mode is a user interface theme that features a bright or white background with dark text and elements. This mode is designed to provide high contrast and clarity, making content easily readable in well-lit environments, such as during the day or in brightly lit rooms."
                  .text
                  .size(17)
                  .color(theamNotifier.isDark ? Colors.white70 : Colors.black)
                  .make()
                  .px16(),
              const SizedBox(
                height: 17,
              ),
              "Dark mode is a user interface theme characterized by a dark background, often black or gray, with light-colored text and elements. This mode is designed to reduce eye strain in low-light or nighttime environments by minimizing the amount of bright light emitted from the screen. "
                  .text
                  .size(17)
                  .color(theamNotifier.isDark ? Colors.white70 : Colors.black)
                  .make()
                  .px16(),
            ],
          ));
    });
  }
}
