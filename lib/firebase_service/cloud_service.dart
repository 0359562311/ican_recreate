import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_project/model/custom_user.dart';

class CloudService{
  static String currentUserUID;
  static var cloudInstance = FirebaseFirestore.instance;
  static Future<void> addUserInformation(CustomUser user) async {
    await cloudInstance.collection("users").doc(user.uid).set(
      {
        "email": user.email,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber
      }
    );
  }
}