import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_dialog.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('images/svg_images/mui_ten_back.svg', height: 28,)
                  )
              ),
            ),
            ///thay doi thong tin
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, Constants.routeEditProfile);
              },
              child: Container(
                height: 58,
                margin: EdgeInsets.only(top:35),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white),
                        bottom: BorderSide(color: Colors.white)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45,bottom: 5,right: 13),
                      child: SvgPicture.asset('images/svg_images/thay_doi_thong_tin.svg',height: 52,),
                    ),
                    Text(
                      'Thay đổi thông tin',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 21
                      ),
                    )
                  ],
                ),
              ),
            ),
            ///thay doi mat khau
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, Constants.routeChangePassword);
              },
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45,bottom: 5,right: 13),
                      child: SvgPicture.asset('images/svg_images/thay_doi_mat_khau.svg',height: 52),
                    ),
                    Text(
                      'Thay đổi mật khẩu',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 21
                      ),
                    )
                  ],
                ),
              ),
            ),
            /// log out
            InkWell(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => true);
                } on FirebaseAuthException catch (e) {
                  // TODO
                  ShowDialog.showMessageDialog(context, FirebaseExceptionConverter.getErrorMessage(e.code));
                }
              },
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 52,bottom: 5,right: 13),
                      child: Tab(
                        icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              Offset(0.0, 24.0),
                              Offset(48.0, 24.0),
                              [
                                Colors.blue[400],
                                Colors.greenAccent,
                              ],
                            );
                          },
                          child: Icon(Icons.logout,size: 48,),
                        ),
                      ),
                    ),
                    Text(
                      'Đăng xuất',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 21
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
