import 'package:ican_project/model/question.dart';

class QuestionConverter{
  static List<Question> convert(List<dynamic> list){
    List<Question> res = List();
    list.forEach((e) {
      res.add(Question(
          question: e['question'],
          a: e['A'],
          b: e['B'],
          c: e['C'],
          d: e['D'],
          rightAnswer: _getRightAnswer(e['rightAnswer'])
      ));
    });
    return res;
  }

  static int _getRightAnswer(e) {
    switch(e){
      case "A": return 0;
      case "B": return 1;
      case "C": return 2;
      case "D": return 3;
      default: return 3;
    }
  }
}