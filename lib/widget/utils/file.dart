import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app_sample/features/detail_screen/book_detail_screen.dart';
import 'package:library_app_sample/theme/theme_modal.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class AHomeScreen extends StatefulWidget {
  const AHomeScreen({super.key});

  @override
  State<AHomeScreen> createState() => _AHomeScreenState();
}

class _AHomeScreenState extends State<AHomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<String> images = [
    "asset/images/book3.jpg",
    "asset/images/book4.jpg",
    "asset/images/book5.jpg",
    "asset/images/book6.jpg",
    "asset/images/book7.jpg",
    "asset/images/book8.jpg",
    "asset/images/book9.jpg"
  ];
  bool isShow = false;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
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
            Container(
              height: isShow
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.55,
              width: double.maxFinite,
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  "Litereasy"
                      .text
                      .color(Colors.white)
                      .size(36)
                      .fontWeight(FontWeight.w900)
                      .makeCentered(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(19, 77, 124, 0.384),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        controller: searchController,
                        style: TextStyle(
                            color: theamNotifier.isDark
                                ? const Color.fromARGB(183, 255, 255, 255)
                                : Colors.black),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search_outlined),
                            prefixIconColor: Color.fromARGB(186, 255, 255, 255),
                            hintText: "What would like to read?",
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color.fromARGB(186, 255, 255, 255),
                            )),
                        onFieldSubmitted: (String _) {
                          setState(() {
                            if (searchController.text == "") {
                              isShow = false;
                            } else {
                              isShow = true;
                            }
                          });
                        },
                      )).px20(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  isShow
                      ? FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("Books")
                              .where('bookName',
                                  isGreaterThanOrEqualTo: searchController.text)
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    (snapshot.data! as dynamic).docs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BookDetailScreen(
                                          snap: (snapshot.data! as dynamic)
                                              .docs[index],
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['bookProfImage']),
                                      ),
                                      title: Text(
                                        (snapshot.data! as dynamic).docs[index]
                                            ['bookName'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                });
                          })
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "New Collection"
                                .text
                                .color(Colors.white)
                                .fontWeight(FontWeight.w900)
                                .size(28)
                                .make(),
                            const Icon(
                              Icons.more_vert_rounded,
                              color: Colors.white,
                            )
                          ],
                        ).px20(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 190,
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("Books")
                          .orderBy('datePublished', descending: false)
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailScreen(
                                        snap: (snapshot.data! as dynamic)
                                            .docs[index]),
                                  ),
                                ),
                                child: Container(
                                  width: 160,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: theamNotifier.isDark
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    (snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['bookProfImage']),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      (snapshot.data! as dynamic)
                                          .docs[index]['bookName']
                                          .toString()
                                          .text
                                          .size(16.5)
                                          .bold
                                          .color(theamNotifier.isDark
                                              ? Colors.white
                                              : Colors.black)
                                          .ellipsis
                                          .make()
                                          .px4(),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      (snapshot.data! as dynamic)
                                          .docs[index]['authorName']
                                          .toString()
                                          .text
                                          .color(Colors.grey)
                                          .bold
                                          .size(17)
                                          .make()
                                          .px(6)
                                    ],
                                  ),
                                ).pOnly(right: 12),
                              );
                            }).px20();
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            isShow
                ? Container()
                : FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection("Books").get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookDetailScreen(
                                    snap:
                                        (snapshot.data! as dynamic).docs[index],
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['bookProfImage']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      height: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          "Managment"
                                              .text
                                              .color(const Color.fromARGB(
                                                  255, 122, 122, 122))
                                              .bold
                                              .size(19)
                                              .make(),
                                          (snapshot.data! as dynamic)
                                              .docs[index]['bookName']
                                              .toString()
                                              .text
                                              .color(theamNotifier.isDark
                                                  ? Colors.white
                                                  : Colors.black)
                                              .bold
                                              .size(23)
                                              .make(),
                                          (snapshot.data! as dynamic)
                                              .docs[index]['authorName']
                                              .toString()
                                              .text
                                              .color(const Color.fromARGB(
                                                  255, 122, 122, 122))
                                              .size(19)
                                              .fontWeight(FontWeight.w500)
                                              .make(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                  )
                                ],
                              ).pOnly(bottom: 20),
                            );
                          }).px20();
                    },
                  ),
          ],
        ),
      );
    });
  }
}
