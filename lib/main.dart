import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ican_project/custom/SubmitDialog.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/ui/grade_chooser.dart';
import 'package:ican_project/ui/list_test/list_test.dart';
import 'package:ican_project/ui/login/login_bloc.dart';
import 'package:ican_project/ui/login/login_view.dart';
import 'package:ican_project/ui/register/register_bloc.dart';
import 'package:ican_project/ui/register/register_view.dart';
import 'package:ican_project/ui/result_of_a_test.dart';
import 'package:ican_project/ui/test_ui.dart';
import 'package:ican_project/ui/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Constants.submitDialog: (context) => SubmitDialog()
      },
    );
  }
}

class Wrapper extends StatelessWidget {

  void _fetchUserInformation(BuildContext context) async{
    await Future.delayed(Duration(seconds: 1));
    await CloudService.getUserInformation();
    Navigator.popAndPushNamed(context, Constants.routeWelcome);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => LoginBloc(), child: Login(),);
    // return FutureBuilder<SharedPreferences>(
    //   future: SharedPreferences.getInstance(),
    //   builder: (context,sp){
    //     if(sp.hasData){
    //       if(sp.data.getString(Constants.sp_logged_in) != null){
    //         CloudService.currentUser.uid = sp.data.getString(Constants.sp_logged_in);
    //         _fetchUserInformation(context);
    //         return SpinKitFoldingCube(color: Colors.blue.shade200,);
    //       }
    //       else return BlocProvider(create:(context) => LoginBloc(), child: Login(),);
    //     }
    //     return SpinKitFoldingCube(color: Colors.blue.shade200,);
    //   },
    // );
  }
}

