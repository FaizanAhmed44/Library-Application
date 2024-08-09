import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app_sample/features/upload_data.dart/methods/storagemethods.dart';
import 'package:library_app_sample/features/upload_data.dart/model/postModel.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadBook(
    String description,
    String bookName,
    String price,
    Uint8List file,
    String language,
    String noOfPages,
    String authorName,
    String pdfUrl,
  ) async {
    String res = 'some error occurred';
    try {
      String bookProfImage =
          await StorageMethods().uploadImageToStorage(file, "books");

      String bookId = const Uuid().v1();

      BookModel book = BookModel(
        datePublished: DateTime.now(),
        price: int.parse(price),
        description: description,
        bookName: bookName,
        bookNameLowercase: bookName.toLowerCase(),
        bookProfImage: bookProfImage,
        language: language,
        noOfPages: noOfPages,
        authorName: authorName,
        bookId: bookId,
        pdfUrl: pdfUrl,
      );

      await _firestore.collection("Books").doc(bookId).set(book.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
