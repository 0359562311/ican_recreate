import 'package:flutter/material.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/canvas_with_result.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/custom/custom_progress_bar.dart';
import 'package:ican_project/model/data_of_a_test.dart';

class ResultOfATest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Test test = ModalRoute.of(context).settings.arguments;
    List<bool> result = [];
    double count = 0;
    for(int i=0; i < test.userAnswer.length; i++){
      if(test.userAnswer[i] == test.listQuestions[i].rightAnswer)
        count++;
      result.add(test.userAnswer[i] == test.listQuestions[i].rightAnswer);
    }
    count /= test.listQuestions.length..roundToDouble();
    double percentage = count*100;
    return CustomLayout(
      title: "Bài test 1",
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Constants.headerBackground,
                  border: Border.symmetric(vertical: BorderSide(
                      color: Constants.headerStroke
                  ))
              ),
              child: Center(
                child: Text(
                  "Kết quả hoàn thành",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            /// percentage
            Container(
              margin: EdgeInsets.symmetric(vertical: 70),
              child: CustomPaint(
                foregroundPainter: CustomProgressBar(percentage),
                size: Size(MediaQuery.of(context).size.width,150),
                child: Text(
                  "${percentage.toInt()}%",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            /// draw result
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16,top: 32),
                      child: Text(
                        "Đúng",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16,top: 32),
                      child: Text(
                        "Sai",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8,),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Stack(
                          children: [
                            Row(
                              children: List.generate(test.listQuestions.length, (index){
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      height: 128,
                                      width: 3,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        "${index+1}",
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 8
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ),
                            /// canvas
                            CustomPaint(
                              /// compute size of canvas
                              size: Size(13.0*test.listQuestions.length,128),
                              painter: CanvasWithResult(result),
                            )
                          ],
                        ),
                      ),
                    )
                )
              ],
            ),
            /// Divider
            Container(
              color: Constants.headerStroke,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            ),
            /// result
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Constants.buttonColor1,
                        Constants.buttonColor2,
                      ]
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FlatButton(
                    onPressed:(){
                      Navigator.pop(context,"test result");
                    },
                    child:  Text(
                      "Xem kết quả",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),
                    )
                ),
              ),
            ),
            /// continue
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Constants.buttonColor1,
                        Constants.buttonColor2,
                      ]
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FlatButton(
                    onPressed:(){
                      Navigator.pushNamedAndRemoveUntil(context, Constants.routeListTest,
                              (Route r) => r.settings.name == Constants.gradeChooser,
                        arguments: test
                      );
                    },
                    child:  Text(
                      "Tiếp tục",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),
                    )
                ),
              ),
            ),
            /// home
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Constants.buttonColor1,
                        Constants.buttonColor2,
                      ]
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FlatButton(
                    onPressed:(){
                      Navigator.popUntil(context, (Route r) => r.settings.name == Constants.routeWelcome);
                    },
                    child:  Text(
                      "Trang chủ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
