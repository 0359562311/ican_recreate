import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/model/data_of_a_test.dart';
import 'package:ican_project/util/question_converter.dart';

class CloudService {
  static var _cloudInstance = FirebaseFirestore.instance;

  static void updateUserInformation(Map<String, dynamic> updateData) async {
    await _cloudInstance
        .collection("users")
        .doc(AuthService.currentUser.uid)
        .update(updateData);
  }

  static Future<List<bool>> getDoneOrNot(String subject, String grade) async {
    var docRef = await _cloudInstance.collection("tests").doc(subject).get();
    int numberOfTest = docRef.get(grade);
    List<bool> res = List.filled(numberOfTest, false);
    var doc = await _cloudInstance.collection("users").doc(AuthService.currentUser.uid).get();
    for(int i=1; i<= numberOfTest;i++){
      if(doc.data().containsKey(subject + grade + i.toString()))
        res[i-1] = true;
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
      doc = await _cloudInstance.collection("users").doc(AuthService.currentUser.uid).get();
      aTest.userAnswer = (doc.data()[aTest.subject + aTest.grade + aTest.testId]["answers"] as List).map((e) => int.parse(e.toString())).toList();
    }
    return aTest;
  }

  static void updateUserAnswer(Test test) async {
    try {
      var doc = _cloudInstance
          .collection("users")
          .doc(AuthService.currentUser.uid);
      int rightAnswer = 0;
      for (int i = 0; i < test.userAnswer.length; i++) {
        if (test.userAnswer[i] == test.listQuestions[i].rightAnswer)
          rightAnswer++;
      }
      await doc.set({
        test.subject + test.grade + test.testId:{
          "rightAnswers": rightAnswer,
          "totalQuestions": test.userAnswer.length,
          "answers": test.userAnswer
        }
      });
    } on FirebaseException catch (e) {
      // TODO
    }
  }

  static Future<double> getPercentage() async{
    var data = await _cloudInstance.collection("users").doc(AuthService.currentUser.uid).get();
    int rightAnswers = 0;
    int totalQuestions = 0;
    data.data().forEach((key, value) {
      rightAnswers += value['rightAnswers'];
      totalQuestions += value['totalQuestions'];
    });
    if(totalQuestions == 0) return 0;
    return rightAnswers/totalQuestions*100;
  }

  static Stream getUserData() {
    try {
      return _cloudInstance.collection("users").doc(AuthService.currentUser.uid).snapshots();
    } on Exception catch (e) {
      // TODO
      return Stream.empty();
    }
  }
}
