import 'dart:async';
import 'package:async/async.dart' show StreamGroup;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_chart.dart';
import 'package:ican_project/custom/custom_circle_avatar.dart';
import 'package:ican_project/custom/custom_dialog.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/firebase_service/storage_service.dart';
import 'package:ican_project/ui/result_of_all_tests/roat_bloc.dart';
import 'package:ican_project/ui/result_of_all_tests/roat_event.dart';
import 'package:ican_project/ui/result_of_all_tests/roat_state.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';

class ROATView extends StatefulWidget {
  @override
  _ROATViewState createState() => _ROATViewState();
}

class _ROATViewState extends State<ROATView> {
  ROATBloc bloc;
  Stream stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      stream = StreamGroup.merge([AuthService.user, CloudService.getUserData()]);
    } on FirebaseAuthException catch (e) {
      // TODO
      ShowDialog.showMessageDialog(context, FirebaseExceptionConverter.getErrorMessage(e.code));
    } on FirebaseException catch(e){
      ShowDialog.showMessageDialog(context, FirebaseExceptionConverter.getErrorMessage(e.code));
    }
    bloc = new ROATBloc();
    _fetchData();
  }

  void _fetchData() async {
    stream.forEach((element) {
      bloc.add(ROATFetchingEvent());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ROATBloc, ROATState>(
      cubit: bloc,
      builder: (context, state) {
        if (state is ROATCompleteState)
          return CustomLayout(
            body: Container(
              child: Column(
                children: [
                  /// Appbar
                  Row(
                    children: [
                      /// avatar
                      Container(
                          margin: EdgeInsets.all(16),
                          child: FutureBuilder(
                              future: StorageService.avatarURL,
                              builder: (context, snap) {
                                if (!snap.hasData || snap.data == null)
                                  return CustomCircleAvatar(
                                    imageProvider:
                                        AssetImage("images/logo_color.png"),
                                  );
                                return CustomCircleAvatar(
                                  imageProvider: NetworkImage(snap.data),
                                );
                              })),

                      /// user name
                      Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Xin chào!",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              AuthService.currentUser.displayName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                      )),

                      /// setting
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "images/svg_images/setting.svg",
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Constants.routeSetting);
                          },
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// correct answer rate
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Tỷ lệ trả lời đúng: ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                margin: EdgeInsets.only(top: 16, bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  color: Color.fromRGBO(255, 97, 95, 1),
                                ),
                                child: Text(
                                  "${state.percentage.floorToDouble()}%",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),

                          ///chart
                          Container(
                            margin: EdgeInsets.only(bottom: 32, top: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 465,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "100%",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      Text(
                                        "50%",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      Text(
                                        "0%",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5, top: 0),
                                      height: 450,
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      child: CustomPaint(
                                        size: Size(
                                            MediaQuery.of(context).size.width -
                                                80,
                                            450),
                                        painter: CustomChart(state.percentage),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5, top: 0),
                                      height: 450,
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 30),
                                            height: 45,
                                            child: Text(
                                              "Xuất sắc",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 30),
                                            height: 45,
                                            child: Text(
                                              "Giỏi",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 30),
                                            height: 45,
                                            child: Text(
                                              "Khá",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 30),
                                            height: 90,
                                            child: Text(
                                              "Trung bình",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 30),
                                            height: 225,
                                            child: Text(
                                              "Yếu",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        return SpinKitFadingCube(
          color: Colors.blue,
        );
      },
      listener: (context, state) {
        if (state is ROATErrorState) {
          ShowDialog.showMessageDialog(context, state.message);
        }
      },
    );
  }
}
