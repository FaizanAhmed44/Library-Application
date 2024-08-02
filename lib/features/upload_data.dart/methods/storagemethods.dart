import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(Uint8List file, String childName) async {
    // first  child is for the folder name like profile,post etc and seconf child is for user folder which contain userId we make seperate folder for each user
    Reference ref = _storage.ref().child(childName).child(const Uuid().v1());

    //upload data
    UploadTask task = ref.putData(file);

    TaskSnapshot snap = await task;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
