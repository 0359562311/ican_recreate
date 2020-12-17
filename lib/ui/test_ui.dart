import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/model/data_of_a_test.dart';
import 'package:ican_project/model/question.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';
import 'package:katex_flutter/katex_flutter.dart';

class TestUI extends StatefulWidget {
  @override
  _TestUIState createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {
  final ScrollController sc = new ScrollController();
  Test test;
  List<Question> listQuestion;
  List<int> userAnswer;
  int currentQuestion = 0;
  bool isLoaded = false;
  bool hasDone;
  BuildContext _context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listQuestion = List.filled(
        10,
        Question(
            a: "loading",
            b: "loading",
            c: "loading",
            d: "loading",
            rightAnswer: 0,
            question: "loading")
    );
    userAnswer = List.filled(10, -1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sc.dispose();

  }

  @override
  Widget build(BuildContext context) {
    test = ModalRoute.of(context).settings.arguments;
    hasDone = test.hasDone;
    _context = context;
    if (!isLoaded) _fetchData();
    return WillPopScope(
      child: isLoaded ? CustomLayout(
        title: "Test " + test.testId,
        body: Column(
          children: [
            /// list question
            Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.03),
                    shape: Border.symmetric(
                        vertical: BorderSide(color: Colors.blue))),
                child: ListView.builder(
                  controller: sc,
                  itemCount: listQuestion.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasDone ?
                          userAnswer[index] == listQuestion[index].rightAnswer?
                          Colors.lightGreen.shade700 : Colors.red.shade500
                              :currentQuestion == index ? Colors.lightBlue : Colors.white.withOpacity(0.07)
                      ),
                      child: FlatButton(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            currentQuestion = index;
                          });
                          sc.animateTo((currentQuestion - 1) * 64.0,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.decelerate);
                        },
                      ),
                    );
                  },
                )),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// question
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      child: CustomTeX(
                          content:
                          "Câu ${currentQuestion + 1}: ${listQuestion[currentQuestion].question}"),
                    ),

                    /// A
                    _answerWidget(0),

                    /// B
                    _answerWidget(1),

                    /// C
                    _answerWidget(2),

                    /// D
                    _answerWidget(3),
                  ],
                ),
              ),
            ),

            /// bottom navigation bar
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          color: Colors.white.withOpacity(0.3),
                          onPressed: () {
                            setState(() {
                              if (currentQuestion > 0) currentQuestion--;
                            });
                            sc.animateTo((currentQuestion - 1) * 64.0,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.decelerate);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 14,
                                color: Colors.white,
                              ),
                              Text(
                                " Câu trước",
                                style:
                                TextStyle(color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          color: Colors.white.withOpacity(0.3),
                          onPressed: () {
                            setState(() {
                              if (currentQuestion < listQuestion.length - 1)
                                currentQuestion++;
                            });
                            sc.animateTo((currentQuestion - 1) * 64.0,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.decelerate);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Câu sau ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SvgPicture.asset(
                                "images/svg_images/mui_ten_bai_test.svg",
                                color: Colors.white,
                                width: 15,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  /// button
                  hasDone ? SizedBox() : Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(91, 119, 255, 1),
                              Color.fromRGBO(55, 216, 185, 1)
                            ])),
                    child: FlatButton(
                      onPressed: () {
                        test.userAnswer = userAnswer;
                        Navigator.of(context)
                            .pushNamed(Constants.submitDialog, arguments: test);
                      },
                      child: Text(
                        "Hoàn\n thành",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ):SpinKitFadingCube(color: Colors.blue.shade500),
      onWillPop: _pressedBack,
    );
  }

  Container _answerWidget(int position) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.blue),
        color: _getAnswerColor(position)
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              color:
                  (userAnswer[currentQuestion] == position && !hasDone) ||
                      (listQuestion[currentQuestion].rightAnswer == position && hasDone) ? Colors.white : null,
            ),
            height: 10,
            width: 10,
            margin: EdgeInsets.all(16),
          ),
          Expanded(
            child: FlatButton(
              child: Container(
                alignment: Alignment.centerLeft,
                child: CustomTeX(content: _getOption(position)),
              ),
              onPressed: () {
                if(!hasDone) setState(() {
                  userAnswer[currentQuestion] = position;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  String _getOption(int position) {
    switch (position) {
      case 0:
        return listQuestion[currentQuestion].a;
      case 1:
        return listQuestion[currentQuestion].b;
      case 2:
        return listQuestion[currentQuestion].c;
      case 3:
        return listQuestion[currentQuestion].d;
    }
    return "";
  }

  void _fetchData() async {
    try {
      test = await CloudService.getDataOfATest(test);
      listQuestion = test.listQuestions;
      userAnswer =
          test.hasDone ? test.userAnswer : List.filled(listQuestion.length, -1);
      setState(() {
        isLoaded = true;
      });
    } on FirebaseException catch (e) {
      // TODO
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(
                    content: Text(
                        FirebaseExceptionConverter.getErrorMessage(e.code)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )));
    }
  }

  Color _getAnswerColor(int position) {
    if(hasDone){
      if(listQuestion[currentQuestion].rightAnswer == position)
        return Colors.lightGreen.shade700;
      else if(userAnswer[currentQuestion] == position)
        return Colors.red.shade500;
      return null;
    }else{
      if(userAnswer[currentQuestion] == position)
        return Colors.lightBlue;
      return null;
    }
  }

  Future<bool> _pressedBack() async {
    Navigator.pushNamedAndRemoveUntil(_context, Constants.routeListTest,
            (route) => route.settings.name == Constants.gradeChooser,
      arguments: test
    );
    return true;
  }
}

class CustomTeX extends StatelessWidget {
  const CustomTeX({
    Key key,
    this.content,
  }) : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return KaTeX(
      laTeXCode: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        textAlign: TextAlign.start,
      ),
      delimiter: r'$',
      displayDelimiter: r'$$',
    );
  }
}
