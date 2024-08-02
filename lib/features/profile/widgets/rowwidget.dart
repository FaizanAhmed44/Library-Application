import 'package:flutter/material.dart';
import 'package:library_app_sample/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileRow extends StatelessWidget {
  final String text;
  final IconData icon;
  const ProfileRow({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(
                    width: 20,
                  ),
                  text.text
                      .size(19)
                      .color(theamNotifier.isDark ? Colors.white : Colors.black)
                      .make(),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ).px16(),
          const SizedBox(
            height: 15,
          ),
          Divider(
            color: theamNotifier.isDark
                ? const Color.fromARGB(93, 255, 255, 255)
                : const Color.fromARGB(61, 0, 0, 0),
          ).px16(),
          const SizedBox(
            height: 15,
          ),
        ],
      );
    });
  }
}
