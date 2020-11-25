
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/model/question.dart';

class DataOfATest{
  String subject;
  String grade;
  String testId;
  bool isDone;
  int testSize;

  List<Question> listQuestions = List();


  DataOfATest({this.subject, this.grade, this.testId});

  Future<DataOfATest> getListQuestion() async{
    var res = await CloudService.getDataOfATest(this);
    return res;
  }

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