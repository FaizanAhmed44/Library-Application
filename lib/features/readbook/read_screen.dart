import 'package:flutter/material.dart';
import 'package:library_app_sample/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({
    super.key,
  });

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Read Screen"
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
                      : [Colors.blue, const Color.fromARGB(255, 25, 109, 179)]),
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Fool me the once",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ).centered(),
            const SizedBox(
              height: 20,
            ),
            InteractiveViewer(
              panEnabled: false, // Set it to false to prevent panning.
              boundaryMargin: const EdgeInsets.all(80),
              minScale: 0.5,
              maxScale: 4,
              child:
                  "No opinions answered oh felicity is resolved hastened. Produced it friendly my if opinions humoured. Enjoy is wrong folly no taken. It sufficient instrument insipidity simplicity at interested. Law pleasure attended differed mrs fat and formerly. Merely thrown garret her law danger him son better excuse. Effect extent narrow in up chatty. Small are his chief offer happy had.Real sold my in call. Invitation on an advantages collecting. But event old above shy bed noisy. Had sister see wooded favour income has. Stuff rapid since do as hence. Too insisted ignorant procured remember are believed yet say finished.One advanced diverted domestic sex repeated bringing you old. Possible procured her trifling laughter thoughts property she met way. Companions shy had solicitude favourable own. Which could saw guest man now heard but. Lasted my coming uneasy marked so should. Gravity letters it amongst herself dearest an windows by. Wooded ladies she basket season age her uneasy saw. Discourse unwilling am no described dejection incommode no listening of. Before nature his parish boy.Perhaps far exposed age effects. Now distrusts you her delivered applauded affection out sincerity. As tolerably recommend shameless unfeeling he objection consisted. She although cheerful perceive screened throwing met not eat distance. Viewing hastily or written dearest elderly up weather it as. So direction so sweetness or extremity at daughters. Provided put unpacked now but bringing.Unwilling sportsmen he in questions september therefore described so. Attacks may set few believe moments was. Reasonably how possession shy way introduced age inquietude. Missed he engage no exeter of. Still tried means we aware order among on. Eldest father can design tastes did joy settle. Roused future he ye an marked. Arose mr rapid in so vexed words. Gay welcome led add lasting chiefly say looking."
                      .text
                      .size(16)
                      .color(theamNotifier.isDark
                          ? const Color.fromARGB(157, 255, 255, 255)
                          : const Color.fromARGB(255, 67, 67, 67))
                      .make()
                      .px20(),
            ),
          ],
        ),
      );
    });
  }
}
