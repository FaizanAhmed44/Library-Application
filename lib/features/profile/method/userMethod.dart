import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:library_app_sample/features/upload_data.dart/methods/storagemethods.dart';
import 'package:uuid/uuid.dart';

class UserMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUser(
      {required Uint8List file, required String uid}) async {
    try {
      String profileUrl =
          await StorageMethods().uploadImageToStorage(file, "Profilepic");

      await _firestore.collection('users').doc(uid).update({
        'profileUrl': profileUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUserInfo(
      {required String name,
      required String bio,
      required String uid,
      required String age,
      required String martialStatus}) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'userName': name,
        'bio': bio,
        'age': age,
        'martialStatus': martialStatus,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> savePosts(
      String bookId, String uid, String name, String postImage) async {
    try {
      String saveId = const Uuid().v1();

      QuerySnapshot<Map<String, dynamic>>? snap;
      snap = await _firestore
          .collection('users')
          .doc(uid)
          .collection('saved')
          .where(
            'bookId',
            isEqualTo: bookId,
          )
          .get();
      if (snap.docs.isNotEmpty) {
        if (snap.docs[0]['bookId'] == bookId) {
          _firestore
              .collection('users')
              .doc(uid)
              .collection('saved')
              .doc(snap.docs[0]['savedId'])
              .delete();
        }
      } else {
        _firestore
            .collection('users')
            .doc(uid)
            .collection("saved")
            .doc(saveId)
            .set({
          'bookId': bookId,
          'uid': uid,
          'name': name,
          'savedId': saveId,
          'postImage': postImage,
          "datePublished": DateTime.now(),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
