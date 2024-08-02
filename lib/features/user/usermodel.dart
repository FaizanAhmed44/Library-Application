import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String bio;
  final String age;
  final String uid;
  final String email;
  final String username;
  final String martialStatus;
  final String profileUrl;

  UserModel({
    required this.age,
    required this.uid,
    required this.bio,
    required this.email,
    required this.username,
    required this.martialStatus,
    required this.profileUrl,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "age": age,
        "uid": uid,
        "bio": bio,
        "userName": username,
        "martialStatus": martialStatus,
        "profileUrl": profileUrl,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      age: snapshot['age'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      email: snapshot['email'],
      username: snapshot['username'],
      martialStatus: snapshot['martialStatus'],
      profileUrl: snapshot['profileUrl'],
    );
  }
}
