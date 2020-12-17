
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/model/question.dart';

class Test{
  String subject;
  String grade;
  String testId;
  bool hasDone;
  List<Question> listQuestions = [];
  List<int> userAnswer = [];

  Test({this.subject, this.grade, this.testId, this.listQuestions, this.userAnswer, this.hasDone});

}

int convert(String s){
  switch(s[s.length-1]){
    case "A":
      return 0;
    case "B":
      return 1;
    case "C":
      return 2;
    case "D":
      return 3;
    default:
      return 0;
  }
}