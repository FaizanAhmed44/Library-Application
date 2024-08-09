import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app_sample/features/detail_screen/book_detail_screen.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Saved"
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
              height: 10,
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('saved')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            DocumentSnapshot snap = await FirebaseFirestore
                                .instance
                                .collection('Books')
                                .doc((snapshot.data! as dynamic).docs[index]
                                    ['bookId'])
                                .get();

                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetailScreen(snap: snap)))
                                .then((val) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        (snapshot.data! as dynamic).docs[index]
                                            ['postImage']),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      });
                })
          ],
        ),
      );
    });
  }
}
