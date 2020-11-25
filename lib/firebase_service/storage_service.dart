import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';

class StorageService{

  static final FirebaseStorage instance = FirebaseStorage.instance;

  static Future<dynamic> get avatarURL async {
    try {
      return instance.ref().child('photo').child(CloudService.currentUser.uid).getDownloadURL();
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return null;
  }

  static Future<dynamic> getAvatarURLByUID(String uid) async {
    try {
      return instance.ref().child('photo').child(uid).getDownloadURL();
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return null;
  }

  static Future<void> uploadAvatar(File file) async{
    var task = instance.ref().child('photo').child(CloudService.currentUser.uid).putFile(file);
    task.onComplete.whenComplete(() => print("done"));
  }
}