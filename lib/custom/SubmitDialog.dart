import 'package:flutter/material.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';

class SubmitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var passingData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        color: Color(0xFF0c1330).withOpacity(0.9),
        alignment: Alignment.center,
        child: Center(
          child: Container(
            height: 300,
            child: Column(
              children: [
                /// ban co muon nop bai khong ?
                Padding(
                  padding: EdgeInsets.only(left: 25,right: 25,top: 50),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: Color(0xFF20224f),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFF33A5F5),
                          width: 1.8,
                        )
                    ),
                    child: Center(
                      child: Text(
                        "Bạn có muốn nộp bài không?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                ///nop bai
                InkWell(
                  onTap: () async {
                    CloudService.updateUserAnswer(passingData);
                    var t = await Navigator.pushReplacementNamed(context, Constants.resultOfATest, arguments: passingData);
                    if(t == "test result")
                      Navigator.pop(context,{"test result" : "test result"});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 47,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [
                              Constants.buttonColor1,
                              Constants.buttonColor2,
                            ]
                        )
                    ),
                    child: Center(
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
                ///huy
                InkWell(
                  onTap: (){
                    Navigator.pop(context,"cancel");
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 13),
                    height: 47,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.white,
                          width: 1.2
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Hủy',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
