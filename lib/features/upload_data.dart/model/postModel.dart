import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String description;
  final int price;
  final String bookName;
  final String bookNameLowercase;
  final datePublished;
  final String bookProfImage;
  final String authorName;
  final String noOfPages;
  final String language;
  final String bookId;
  final String pdfUrl;

  BookModel({
    required this.datePublished,
    required this.price,
    required this.description,
    required this.bookName,
    required this.bookProfImage,
    required this.authorName,
    required this.noOfPages,
    required this.language,
    required this.bookId,
    required this.pdfUrl,
    required this.bookNameLowercase,
  });

  Map<String, dynamic> toJson() => {
        "bookName": bookName,
        "price": price,
        "bookProfImage": bookProfImage,
        "description": description,
        "datePublished": datePublished,
        "authorName": authorName,
        "noOfPages": noOfPages,
        "language": language,
        "bookId": bookId,
        "pdfUrl": pdfUrl,
        "bookNameLowercase": bookNameLowercase,
      };

  static BookModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BookModel(
      bookProfImage: snapshot['bookProfImage'],
      price: snapshot['uid'],
      description: snapshot['description'],
      bookName: snapshot['bookName'],
      datePublished: snapshot['datePublished'],
      authorName: snapshot['authorName'],
      noOfPages: snapshot['noOfPages'],
      language: snapshot['language'],
      bookId: snapshot['bookId'],
      pdfUrl: snapshot['pdfUrl'],
      bookNameLowercase: snapshot['bookNameLowercase'],
    );
  }
}
