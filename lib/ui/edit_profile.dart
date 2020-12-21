import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ican_project/custom/custom_dialog.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/firebase_service/storage_service.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';
import 'package:image_picker/image_picker.dart';

import '../consts.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  final passwordCondition = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  final emailRegex = RegExp(r'^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$');
  File photoFile;
  TextEditingController email = TextEditingController(text: AuthService.currentUser.email??"");
  TextEditingController fullName = TextEditingController(text: AuthService.currentUser.displayName??"");

  StreamController<String> streamController = StreamController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sinkStream();
  }

  void sinkStream() async {
    var a = await StorageService.avatarURL;
    streamController.sink.add(a as String);
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// avatar
              Padding(
                padding: EdgeInsets.only(top:90),
                child: Container(
                  height: 130,
                  width: 130,
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: Center(
                            child: StreamBuilder<String>(
                              stream: streamController.stream,
                              builder: (context,snapshot){
                                if(snapshot.hasData){
                                  print(snapshot.data);
                                  if(snapshot.data == null) {
                                    return CircleAvatar(
                                      radius: 65,
                                      backgroundImage: AssetImage("images/logo_white.png"),
                                    );
                                  }
                                  else if(snapshot.data == "chose")
                                    return CircleAvatar(backgroundImage: FileImage(photoFile,),radius: 65,);
                                  // return Image.network(snapshot.data,fit: BoxFit.cover,);
                                  return CircleAvatar(backgroundImage: NetworkImage(snapshot.data),radius: 65,);
                                }
                                return CircleAvatar(
                                  radius: 65,
                                  backgroundImage: AssetImage("images/logo_white.png"),
                                );
                              },
                            )
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: ()async{
                              var file = await ImagePicker().getImage(source: ImageSource.gallery);
                              if(file != null){
                                photoFile = File(file.path);
                                streamController.sink.add("chose");
                              }
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconSample(),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              /// full name
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Họ và tên',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: fullName,
                  validator: (val){
                    return val.isEmpty? "Nhập vào họ tên":null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: buildInputDecoration(),
                ),
              ),
              /// email
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Địa chỉ email',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: email,
                  validator: (val){
                    return emailRegex.hasMatch(val) && val!=null?null:"email không hợp lệ";
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: buildInputDecoration(),
                ),
              ),
              /// xac nhan
              Padding(
                padding: EdgeInsets.fromLTRB(60, 17, 60, 0),
                child: RaisedButton(
                  onPressed: () async {
                    if(formKey.currentState.validate()){
                      try {
                        if(photoFile != null)
                          StorageService.uploadAvatar(photoFile);
                        if(fullName.text != AuthService.currentUser.displayName)
                          await AuthService.currentUser.updateProfile(displayName: fullName.text);
                        if(email.text != AuthService.currentUser.email) {
                          await AuthService.currentUser.verifyBeforeUpdateEmail(email.text);
                          await ShowDialog.showMessageDialog(context, "Xác nhận email mới trước khi đổi qua đường link xác nhận gửi qua email.");
                        }
                        await AuthService.currentUser.reload();
                        ShowDialog.showMessageDialog(context, "Đổi thành công.");
                      } on FirebaseAuthException catch (e) {
                        // TODO
                        ShowDialog.showMessageDialog(context, FirebaseExceptionConverter.getErrorMessage(e.code));
                      } on FirebaseException catch(e){
                        ShowDialog.showMessageDialog(context, FirebaseExceptionConverter.getErrorMessage(e.code));
                      }
                    }
                  },
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
                          Constants.buttonColor2,
                        ],
                      ),
                    ),
                    padding:EdgeInsets.all(10.0),
                    child: Center(
                        child: Text('Xác nhận', style: TextStyle(fontSize: 20))
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      title: "Thay đổi thông tin",
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white,),
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide:BorderSide(
              width: 1,
              color: Colors.white
          )
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide:BorderSide(
              width: 1,
              color: Colors.red
          )
      ),
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
    );
  }
}
//custom gradient icon
class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: Container(
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
class IconSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      Icons.camera_alt,
      25,
      LinearGradient(
        colors: <Color>[
          Constants.buttonColor1,
          Constants.buttonColor2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
