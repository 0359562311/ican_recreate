import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/model/data_of_a_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts.dart';

class ShowDialog{
  static Future showDialog(BuildContext context,Test passingData){
    Container(
      color: Color(0xFF0c1330).withOpacity(0.9),
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
                  String t = await Navigator.pushReplacementNamed(context, Constants.resultOfATest, arguments: passingData);
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
                            Color(0xFF5B77FF),
                            Color(0xFF37D8B9),
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
    );
  }
  static void showExitDialog(context){
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 50),
      pageBuilder: (_, __, ___) {
        return Opacity(
          opacity: 0.9,
          child: Material(
            child: Container(
              color: Color(0xFF0c1330),
              child: Center(
                child: Container(
                  height: 300,
                  child: Column(
                    children: [
                      /// ban co muon thoat khong ?
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
                              "Bạn có muốn thoát không?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///xac nhan
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          var sp = await SharedPreferences.getInstance();
                          await sp.remove(Constants.sp_logged_in);
                          Navigator.popUntil(context, ModalRoute.withName(Constants.routeLogin));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 47,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF5B77FF),
                                    Color(0xFF37D8B9),
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
                          Navigator.pop(context);
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
          ),
        );
      },
    );
  }
  static Future<Map> showSubmitDialog(BuildContext context,Test passingData){
    return showGeneralDialog<Map>(
      context: context,
      transitionDuration: Duration(milliseconds: 50),
      pageBuilder: (_, __, ___) {
        return Opacity(
          opacity: 0.9,
          child: Container(
            color: Color(0xFF0c1330),
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
                        String t = await Navigator.pushReplacementNamed(context, Constants.resultOfATest, arguments: passingData);
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
                                  Color(0xFF5B77FF),
                                  Color(0xFF37D8B9),
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
      },
    );
  }
  static void showErrorDialog(context, String errorMessage){
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 50),
      pageBuilder: (_, __, ___) {
        return Opacity(
          opacity: 0.9,
          child: Material(
            child: Container(
              color: Color(0xFF0c1330),
              child: Center(
                child: Container(
                  height: 300,
                  child: Column(
                    children: [
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
                              errorMessage,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 47,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF5B77FF),
                                    Color(0xFF37D8B9),
                                  ]
                              )
                          ),
                          child: Center(
                            child: Text(
                              'Trở lại',
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
          ),
        );
      },
    );
  }

}

