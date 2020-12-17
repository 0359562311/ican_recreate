import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_project/model/custom_user.dart';
import 'package:ican_project/model/data_of_a_test.dart';
import 'package:ican_project/util/question_converter.dart';

class CloudService {
  static CustomUser currentUser = CustomUser();
  static var _cloudInstance = FirebaseFirestore.instance;

  static Future<void> getCurrentUserInFormation(String uid) async {
    var data = await _cloudInstance.collection("users").doc(uid).get();
    var map = data.data();
    currentUser
      ..uid = uid
      ..fullName = map['fullName']
      ..phoneNumber = map['phoneNumber']
      ..photoURL = map['photoURL'];
  }

  static void updateUserInformation(Map<String, dynamic> updateData) async {
    await _cloudInstance
        .collection("users")
        .doc(currentUser.uid)
        .update(updateData);
  }

  static Future<void> getUserInformation() async {
    print(currentUser.uid);
    var doc =
        await _cloudInstance.collection("users").doc(currentUser.uid).get();
    currentUser
      ..fullName = doc.get("fullName")
      ..phoneNumber = doc.get("phoneNumber")
      ..email = doc.get("email");
  }

  static Future<void> addUserInformation(CustomUser user) async {
    await _cloudInstance.collection("users").doc(user.uid).set({
      "email": user.email,
      "fullName": user.fullName,
      "phoneNumber": user.phoneNumber
    });
  }

  static Future<List<bool>> getDoneOrNot(String subject, String grade) async {
    var docRef = await _cloudInstance.collection("tests").doc(subject).get();
    int numberOfTest = docRef.get(grade);
    List<bool> res = List.filled(numberOfTest, false);
    CollectionReference colRef;
    try {
      colRef = _cloudInstance
            .collection("users")
            .doc(CloudService.currentUser.uid)
            .collection("hasDone");
    } on Exception catch (e) {
      // TODO
      return res;
    }
    for (int i = 1; i <= numberOfTest; i++) {
      try {
        var t = await colRef.doc(subject + grade + i.toString()).get();
        if(t.exists)
          res[i-1] = true;
      } on Exception catch (e) {
        res[i-1] = false;
      }
    }
    print(res);
    return res;
  }

  static Future<Test> getDataOfATest(Test aTest) async {
    DocumentReference docRef = _cloudInstance
        .collection("tests")
        .doc(aTest.subject)
        .collection(aTest.grade)
        .doc(aTest.testId);
    var doc = await docRef.get();
    print(doc.get("data"));
    aTest.listQuestions = QuestionConverter.convert(doc.get("data"));

    if(aTest.hasDone) {
      docRef = _cloudInstance.collection("users").doc(currentUser.uid).collection("hasDone")
          .doc(aTest.subject + aTest.grade + aTest.testId);
      doc = await docRef.get();
      aTest.userAnswer = (doc.get("answer") as List).map((e) => int.parse(e.toString())).toList();
    }
    return aTest;
  }

  static void updateUserAnswer(Test test) {
    try {
      var doc = _cloudInstance
          .collection("users")
          .doc(currentUser.uid)
          .collection("hasDone")
          .doc(test.subject + test.grade + test.testId);
      int rightAnswer = 0;
      for (int i = 0; i < test.userAnswer.length; i++) {
        if (test.userAnswer[i] == test.listQuestions[i].rightAnswer)
          rightAnswer++;
      }
      doc.set({
        "rightAnswer": rightAnswer,
        "totalQuestions": test.userAnswer.length,
        "answer": test.userAnswer
      });
    } on FirebaseException catch (e) {
      // TODO
    }
  }
}
