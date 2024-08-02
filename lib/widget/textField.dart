import 'package:flutter/material.dart';
import 'package:library_app_sample/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool isPass;
  final IconData icon;

  const TextFieldInput(
      {required this.controller,
      required this.text,
      required this.icon,
      this.isPass = false});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return TextFormField(
        controller: controller,
        obscureText: isPass,
        style: TextStyle(
            color: theamNotifier.isDark
                ? const Color.fromARGB(179, 255, 255, 255)
                : Colors.black),
        decoration: InputDecoration(
          // icon: Icon(Icons.email_outlined),
          prefixIcon: Icon(icon),
          labelText: text,
          border: const OutlineInputBorder(),
        ),
      );
    });
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int maxlines;
  final bool isTrue;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    this.maxlines = 1,
    this.isTrue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return TextFormField(
        controller: controller,
        obscureText: isTrue,
        style: TextStyle(
            color: theamNotifier.isDark
                ? const Color.fromARGB(169, 255, 255, 255)
                : Colors.black),
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: GestureDetector(
            child: text == "*********"
                ? const Icon(Icons.remove_red_eye).pOnly(right: 12)
                : const SizedBox(),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
            ),
            borderRadius: BorderRadius.all(Radius.circular(34)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: theamNotifier.isDark ? Colors.white54 : Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(34)),
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Enter your $text";
          }
          return null;
        },
        maxLines: maxlines,
      );
    });
  }
}
