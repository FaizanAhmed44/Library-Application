import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:library_app_sample/features/detail_screen/pdfscreen.dart';
import 'package:library_app_sample/features/profile/method/userMethod.dart';

import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:library_app_sample/shared/widget/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class BookDetailScreen extends StatefulWidget {
  final snap;
  const BookDetailScreen({super.key, required this.snap});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isShowSaved = false;
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();
    getIsSaved();
  }

  void getIsSaved() async {
    try {
      QuerySnapshot? snap;
      snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('saved')
          .where('bookId', isEqualTo: widget.snap['bookId'])
          .get();
      if (snap.docs.isNotEmpty) {
        if (snap.docs[0]['bookId'] == widget.snap['bookId']) {
          isShowSaved = true;
        }
      } else {
        isShowSaved = false;
      }
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Book Details"
                  .text
                  .color(Colors.white)
                  .size(25)
                  .fontWeight(FontWeight.w800)
                  .make(),
              Row(
                children: [
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
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await UserMethods().savePosts(
                        widget.snap['bookId'],
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.snap['bookName'],
                        widget.snap['bookProfImage'],
                      );
                      setState(() {});
                      getIsSaved();
                      setState(() {});
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: theamNotifier.isDark
                            ? isShowSaved
                                ? const Icon(Icons.favorite)
                                : const Icon(
                                    Icons.favorite_border,
                                  )
                            : isShowSaved
                                ? const Icon(
                                    Icons.favorite,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                  )),
                  ),
                ],
              )
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
          shrinkWrap: true,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 280,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 150,
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
                  Container(
                    width: 200,
                    height: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage(widget.snap['bookProfImage']),
                            fit: BoxFit.cover)),
                  ).centered()
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            widget.snap['bookName']
                .toString()
                .text
                .size(27)
                .color(theamNotifier.isDark ? Colors.white : Colors.black)
                .bold
                .make()
                .centered(),
            const SizedBox(
              height: 7,
            ),
            widget.snap['authorName']
                .toString()
                .text
                .size(21)
                .color(Colors.grey)
                .bold
                .make()
                .centered(),
            const SizedBox(
              height: 9,
            ),
            Wrap(
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: Colors.orange,
                ).px(3);
              }),
            ).centered(),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    widget.snap['noOfPages']
                        .toString()
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .fontWeight(FontWeight.w800)
                        .size(22)
                        .make(),
                    "Page"
                        .text
                        .color(Colors.grey)
                        .fontWeight(FontWeight.w800)
                        .size(18)
                        .make(),
                  ],
                ),
                Container(
                  height: 35,
                  width: 2,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    widget.snap['language']
                        .toString()
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .fontWeight(FontWeight.w800)
                        .size(22)
                        .make(),
                    "Language"
                        .text
                        .color(Colors.grey)
                        .fontWeight(FontWeight.w800)
                        .size(18)
                        .make(),
                  ],
                ),
                Container(
                  height: 35,
                  width: 2,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    "2018"
                        .text
                        .color(
                            theamNotifier.isDark ? Colors.white : Colors.black)
                        .fontWeight(FontWeight.w800)
                        .size(22)
                        .make(),
                    "Published"
                        .text
                        .color(Colors.grey)
                        .fontWeight(FontWeight.w800)
                        .size(18)
                        .make(),
                  ],
                ),
              ],
            ).px20(),
            const SizedBox(
              height: 24,
            ),
            widget.snap['description']
                .toString()
                .text
                .bold
                .color(Colors.grey)
                .size(18)
                .make()
                .px(22),
            const SizedBox(
              height: 18,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          bookPdfUrl: widget.snap['pdfUrl'],
                          bookName: widget.snap['bookName'],
                        )));
              },
              child: Container(
                width: double.maxFinite,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Color.fromARGB(255, 25, 109, 179)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: "Read"
                    .text
                    .color(Colors.white)
                    .bold
                    .size(25)
                    .makeCentered(),
              ).px20(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }
}
