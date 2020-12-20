import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_dialog.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isChanging = false;

  @override
  Widget build(BuildContext context) {
    if(isChanging) return SpinKitFadingCube(color: Colors.blue,);
    return CustomLayout(
      title: "Thay đổi mật khẩu",
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top:40),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Center(
                    child: Image(
                      height: 75,
                      image: AssetImage('images/logo_white.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ///mat khau hien tai
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Mật khẩu hiện tại',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: oldPasswordController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s){
                    if(s.length == 0) return "Điền đầy đủ thông tin";
                    return null;
                  },
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 1,
                            color: Colors.white
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.lightBlue[800]
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.red
                        )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.lightBlue[800]
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ///mat khau moi
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Mật khẩu mới',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: newPasswordController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s){
                    if(s.length == 0) return "Điền đầy đủ thông tin";
                    return null;
                  },
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 1,
                            color: Colors.white
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.lightBlue[800]
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.red
                        )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.lightBlue[800]
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              /// nhap lai mat khau moi
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Nhập lại mật khẩu mới',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s){
                    if(s.length == 0) return "Điền đầy đủ thông tin";
                    if(s != newPasswordController.text) return "Không giống mật khẩu mới.";
                    return null;
                  },
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 1,
                            color: Colors.white
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.lightBlue[800]
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.red
                        )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:BorderSide(
                            width: 2,
                            color: Colors.lightBlue[800]
                        )
                    ),
                  ),
                ),
              ),
              ///xac nhan
              Padding(
                padding: EdgeInsets.fromLTRB(60, 17, 60, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Constants.buttonColor1,
                          Constants.buttonColor2
                        ],
                      ),
                    ),
                    padding:EdgeInsets.all(10.0),
                    child: Center(
                        child: Text('Xác nhận', style: TextStyle(fontSize: 20))
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate() && !isChanging){
                      try {
                        setState(() {
                          isChanging = true;
                        });
                        await AuthService.changePassword(oldPasswordController.text, newPasswordController.text);
                        setState(() {
                          isChanging = false;
                        });
                        ShowDialog.showMessageDialog(context, "Đổi thành công");
                      } on FirebaseAuthException catch (e) {
                        // TODO
                        setState(() {
                          isChanging = false;
                        });
                        ShowDialog.showMessageDialog(context, FirebaseExceptionConverter.getErrorMessage(e.code));
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
