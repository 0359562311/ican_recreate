class Question{
  final String question;
  final String a;
  final String b;
  final String c;
  final String d;
  final int rightAnswer;

  Question({this.question, this.a, this.b, this.c, this.d,
    this.rightAnswer});

  @override
  String toString() {
    return 'Question{question: $question, a: $a, b: $b, c: $c, d: $d, rightAnswer: $rightAnswer}';
  }
}