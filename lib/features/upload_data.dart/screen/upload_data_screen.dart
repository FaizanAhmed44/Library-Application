import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app_sample/features/upload_data.dart/methods/upload_firestore_methods.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';
import 'package:library_app_sample/shared/widget/textField.dart';
import 'package:library_app_sample/shared/widget/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController noOfPagesController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  bool isLoading = false;
  String? pdfUrl;
  File? _pdfFile;

  Uint8List? images;
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  Future<void> getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  void selectImages() async {
    var res = await pickImage(ImageSource.gallery);
    setState(() {
      images = res;
    });
  }

  Future<void> _uploadPdf() async {
    // Upload PDF
    final pdfPath = 'pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf';
    final pdfRef = FirebaseStorage.instance.ref().child(pdfPath);
    await pdfRef.putFile(_pdfFile!);
    pdfUrl = await pdfRef.getDownloadURL();
    print(pdfUrl);
  }

  void uploadBook() async {
    setState(() {
      isLoading = true;
    });
    await _uploadPdf();

    String res = await FirestoreMethods().uploadBook(
      descriptionController.text,
      productNameController.text,
      priceController.text,
      images!,
      languageController.text,
      noOfPagesController.text,
      authorNameController.text,
      pdfUrl!,
    );
    if (res == "success") {
      print("sucessfully upload");
      setState(() {
        priceController.clear();
        descriptionController.clear();
        productNameController.clear();
        images = null;
        authorNameController.clear();
        noOfPagesController.clear();
        languageController.clear();
        pdfUrl = null;
        _pdfFile = null;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TheamModal theamNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Add Books"
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
        body: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: getPdf,
                  child: _pdfFile != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "PDF Selected"
                                .text
                                .xl4
                                .color(theamNotifier.isDark
                                    ? Colors.white
                                    : Colors.black)
                                .make(),
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.edit_outlined)
                          ],
                        )
                      : "Tap to select PDF"
                          .text
                          .color(theamNotifier.isDark
                              ? Colors.white
                              : Colors.black)
                          .xl4
                          .make(),
                ),
                const SizedBox(
                  height: 40,
                ),
                images != null
                    ? Container(
                        height: 180,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: MemoryImage(images!))),
                      )
                    : GestureDetector(
                        onTap: () {
                          selectImages();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: theamNotifier.isDark
                              ? Colors.white54
                              : Colors.black,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                "Select Product Image"
                                    .text
                                    .color(Colors.grey.shade400)
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: productNameController, text: "Book Name"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: descriptionController,
                  text: "Description",
                  maxlines: 7,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: authorNameController, text: "Author Name"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: languageController, text: "Language"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(controller: priceController, text: "Price"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: noOfPagesController, text: "No of pages"),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => uploadBook(),
                  child: Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue,
                          Color.fromARGB(255, 25, 109, 179)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ).centered()
                        : "Upload"
                            .text
                            .color(Colors.white)
                            .size(19.6)
                            .bold
                            .make()
                            .centered(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ).px12(),
          ),
        ),
      );
    });
  }
}
