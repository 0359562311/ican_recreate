import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/custom/submit_dialog.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/ui/change_password.dart';
import 'package:ican_project/ui/edit_profile.dart';
import 'package:ican_project/ui/grade_chooser.dart';
import 'package:ican_project/ui/list_test/list_test.dart';
import 'package:ican_project/ui/login/login_bloc.dart';
import 'package:ican_project/ui/login/login_view.dart';
import 'package:ican_project/ui/register/register_bloc.dart';
import 'package:ican_project/ui/register/register_view.dart';
import 'package:ican_project/ui/result_of_a_test.dart';
import 'package:ican_project/ui/setting.dart';
import 'package:ican_project/ui/test_ui.dart';
import 'package:ican_project/ui/welcome.dart';

import 'consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => Wrapper(),
        Constants.routeLogin: (context) => Login(),
        Constants.routeRegister: (context) => BlocProvider(create:(context) => RegisterBloc(), child: Register(),),
        Constants.routeWelcome: (context) => WelcomeScreen(),
        Constants.gradeChooser: (context) => GradeChooser(),
        Constants.routeListTest: (context) => ListTest(),
        Constants.test: (context) => TestUI(),
        Constants.resultOfATest: (context) => ResultOfATest(),
        Constants.submitDialog: (context) => SubmitDialog(),
        Constants.routeSetting: (context) => Setting(),
        Constants.routeEditProfile: (context) => EditProfile(),
        Constants.routeChangePassword: (context) => ChangePassword(),
      },
    );
  }
}

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if(AuthService.currentUser == null)
      return BlocProvider(create:(context) => LoginBloc(), child: Login(),);
    else
      return WelcomeScreen();
  }
}

