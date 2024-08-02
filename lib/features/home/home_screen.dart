import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app_sample/features/detail_screen/book_detail_screen.dart';
import 'package:library_app_sample/theme/theme_modal.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  bool isFilter = false;
  double _lowerValue = 200;
  double _upperValue = 800;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void _showFilterSheet(TheamModal theamNotifier) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Filter by Price",
                      style: TextStyle(
                          color: theamNotifier.isDark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    RangeSlider(
                      values: RangeValues(_lowerValue, _upperValue),
                      min: 150,
                      max: 800,
                      divisions: 20,
                      activeColor:
                          theamNotifier.isDark ? Colors.white : Colors.black,
                      labels: RangeLabels(
                        _lowerValue.round().toString(),
                        _upperValue.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setModalState(() {
                          _lowerValue = values.start;
                          _upperValue = values.end;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // isShow = true;
                          isFilter = true;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 120,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue,
                              Color.fromARGB(255, 25, 109, 179)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: "Apply"
                            .text
                            .color(Colors.white)
                            .size(19.6)
                            .bold
                            .make()
                            .centered(),
                      ).px20(),
                    ),
                  ],
                ),
              );
            },
          );
        });
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: isShow
                                ? MediaQuery.of(context).size.width / 1.3
                                : MediaQuery.of(context).size.width / 1.3,
                            child: TextFormField(
                              controller: searchController,
                              style: TextStyle(
                                  color: theamNotifier.isDark
                                      ? const Color.fromARGB(183, 255, 255, 255)
                                      : Colors.white),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(186, 255, 255, 255),
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
                                    isFilter = false;
                                  } else {
                                    isShow = true;
                                    isFilter = false;
                                  }
                                });
                              },
                            ),
                          ),
                          isShow
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isShow = false;
                                      searchController.clear();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ))
                              : Container()
                        ],
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
                                physics: const NeverScrollableScrollPhysics(),
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
                                      subtitle: Text(
                                        "\$${(snapshot.data! as dynamic).docs[index]['uid']}",
                                        style: const TextStyle(
                                            color: Colors.white),
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
                            GestureDetector(
                              onTap: () => _showFilterSheet(theamNotifier),
                              child: const Icon(
                                Icons.filter_list,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ).px20(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  isShow
                      ? Container()
                      : SizedBox(
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
                                  itemCount:
                                      (snapshot.data! as dynamic).docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookDetailScreen(
                                                  snap: (snapshot.data!
                                                          as dynamic)
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          (snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index][
                                                              'bookProfImage']),
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
            isFilter
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Books")
                        .where('uid', isGreaterThanOrEqualTo: _lowerValue)
                        .where('uid', isLessThanOrEqualTo: _upperValue)
                        .get(),
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
                                    height: 150,
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
                                      height: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          "Management"
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
                                          "\$ ${(snapshot.data! as dynamic).docs[index]['uid']} "
                                              .text
                                              .color(theamNotifier.isDark
                                                  ? Colors.white
                                                  : Colors.black)
                                              .bold
                                              .size(17)
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
                  )
                : Container(),
            isFilter
                ? Container()
                : isShow
                    ? Container()
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Books")
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
                              physics: const NeverScrollableScrollPhysics(),
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
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 130,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage((snapshot.data!
                                                    as dynamic)
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
                                          height: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              "Management"
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
                                              "\$ ${(snapshot.data! as dynamic).docs[index]['uid']}"
                                                  .text
                                                  .color(theamNotifier.isDark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .size(18)
                                                  .fontWeight(FontWeight.w600)
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
