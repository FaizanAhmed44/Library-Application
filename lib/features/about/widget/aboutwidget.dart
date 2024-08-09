import 'package:flutter/material.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HelpWidgetRowScreen extends StatelessWidget {
  final String text;
  final double? size;
  const HelpWidgetRowScreen({super.key, required this.text, this.size = 19});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text.text
              .size(size)
              .color(
                theamNotifier.isDark ? Colors.white : Colors.black,
              )
              .make(),
          Icon(
            Icons.arrow_forward_ios,
            size: 17,
            color: theamNotifier.isDark ? Colors.white : Colors.black,
          )
        ],
      ).px16();
    });
  }
}
