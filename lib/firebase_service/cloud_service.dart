import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_project/model/custom_user.dart';
import 'package:ican_project/model/data_of_a_test.dart';
import 'package:ican_project/model/question.dart';
import 'package:ican_project/util/question_converter.dart';

class CloudService{
  static CustomUser currentUser = CustomUser();
  static var cloudInstance = FirebaseFirestore.instance;

  static Future<void> getCurrentUserInFormation(String uid) async{
    var data = await cloudInstance.collection("users").doc(uid).get();
    var map = data.data();
    currentUser..uid = uid
    ..fullName = map['fullName']
    ..phoneNumber = map['phoneNumber']
    ..photoURL = map['photoURL'];
  }

  static void updateUserInformation(Map<String,dynamic> updateData) async{
    await cloudInstance.collection("users").doc(currentUser.uid).update(updateData);
  }

  static void getUserInformation() async{
    await cloudInstance.collection("users").doc(currentUser.uid).get();
  }

  static Future<void> addUserInformation(CustomUser user) async {
    await cloudInstance.collection("users").doc(user.uid).set(
      {
        "email": user.email,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber
      }
    );
  }

  static Future<DataOfATest> getDataOfATest(DataOfATest aTest) async{
    DocumentReference docRef = cloudInstance.collection("tests")
      .doc(aTest.subject).collection(aTest.grade).doc(aTest.testId);
    var doc = await docRef.get();
    aTest.listQuestions = QuestionConverter.convert(doc.get("data"));
    return aTest;
  }
}