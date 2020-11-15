import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/register/register_bloc.dart';
import 'package:ican_project/register/register_state.dart';

/// RegisterScreen
class Register extends StatelessWidget {
  final passwordCondition = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  final emailRegex =
      RegExp(r'^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$');
  final phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc,RegisterState>(
      listener: (context,state){},
      builder: (context,state){
        if(state is RegisterLoadingState)
          return SpinKitChasingDots(color: Colors.blue.shade800);
        else if(state is RegisterErrorState)
          return AlertDialog(
            content: Text(state.error),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        else if(state is RegisterSuccessfulState)
          return AlertDialog(
            content: Text("Register successfully"),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        return CustomLayout(
          title: "Đăng ký",
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// logo
                  Padding(
                    padding: EdgeInsets.only(top: 40),
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

                  /// fullname
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: fullNameController,
                      validator: (val) {
                        return val.isEmpty ? "Nhập vào họ tên" : null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration:
                      buildInputDecoration().copyWith(labelText: "Họ và tên"),
                    ),
                  ),
                  SizedBox(height: 20),

                  /// phone number
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      validator: (val) {
                        return phoneRegex.hasMatch(val)
                            ? null
                            : "Số điện thoại không hợp lệ";
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: buildInputDecoration()
                          .copyWith(labelText: "Số điện thoại"),
                    ),
                  ),
                  SizedBox(height: 20),

                  /// email
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      validator: (val) {
                        return emailRegex.hasMatch(val) && val != null
                            ? null
                            : "email không hợp lệ";
                      },
                      style: TextStyle(color: Colors.white),
                      decoration:
                      buildInputDecoration().copyWith(labelText: "Email"),
                    ),
                  ),
                  SizedBox(height: 20),

                  /// password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return passwordCondition.hasMatch(val)
                            ? null
                            : "ít nhất 8 kí tự bao gồm chữ và số";
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide:
                            BorderSide(width: 2, color: Colors.redAccent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue[800])),
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Mật khẩu",
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(width: 2, color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue[800])),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  /// confirm
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return passwordController.text == val ? null : "mật khẩu không khớp";
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Nhập lại mật khẩu",
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(width: 2, color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue[800])),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide:
                            BorderSide(width: 2, color: Colors.redAccent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue[800])),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 45, 60, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {}
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Constant.buttonColor1,
                              Constant.buttonColor2,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                            child: Text('Đăng ký', style: TextStyle(fontSize: 20))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 20),
      labelText: "Họ và tên",
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 2, color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 2, color: Colors.lightBlue[800])),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 2, color: Colors.redAccent)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 2, color: Colors.lightBlue[800])),
      labelStyle: TextStyle(color: Colors.white),
    );
  }
}
