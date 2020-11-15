import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/login/login_bloc.dart';
import 'package:ican_project/login/login_event.dart';
import 'package:ican_project/login/login_state.dart';

import '../consts.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  final passwordCondition = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  final emailRegex =
      RegExp(r'^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$');
  bool showPassword = false;
  String username = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of(context);
    return BlocConsumer(
      listener: (context,state){
        if(state is LoginErrorState){
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage))
          );
        }
        else{
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context,state){
        if(state is LoginLoadingState) {
          return Center(child: SizedBox(height: 50,width: 50,child: CircularProgressIndicator()));
        }
        return Scaffold(
            body: CustomLayout(
              title: "Đăng nhập",
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// logo
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 15),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.lightBlueAccent[200],
                                  blurRadius: 20,
                                  offset: Offset(0, 0))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image(
                              image: AssetImage("images/logo_color.png"),
                            ),
                          ),
                        ),
                      ),
                      /// app name
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "ĐỘI NGŨ GIA SƯ 4.0",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      /// email
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          validator: (val) => !emailRegex.hasMatch(val)
                              ? "Email không hợp lệ"
                              : null,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            labelText: "Email",
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.lightBlue[800])),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.redAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.lightBlue[800])),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          onChanged: (String s) {
                            username = s;
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      /// password
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          // validator: (val) => !passwordCondition.hasMatch(val)?"Mật khẩu không hợp lệ":null,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            labelText: "Mật khẩu",
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.lightBlue[800])),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.redAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.lightBlue[800])),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          obscureText: true,
                          onChanged: (String s) {
                            password = s;
                          },
                        ),
                      ),
                      /// quen mat khau (forgot password)
                      Padding(
                        padding: EdgeInsets.only(right: 45),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            child: Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              print("pressed Quen mat khau");
                              Navigator.pushNamed(
                                  context, Constant.routeForgot_password);
                            },
                          ),
                        ),
                      ),
                      /// Đăng nhập
                      Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Constant.buttonColor1,
                                  Constant.buttonColor2,
                                ])),
                        child: FlatButton(
                          child: Text(
                            "Đăng nhập",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _bloc.add(LoginWithEmailAndPassword(username, password));
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      /// Đăng ký
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "____________",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 3,
                                      decorationColor: Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Constant.routeRegister);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "____________",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 3,
                                      decorationColor: Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
