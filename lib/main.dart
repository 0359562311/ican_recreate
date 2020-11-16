import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/ui/login/login_bloc.dart';
import 'package:ican_project/ui/login/login_view.dart';
import 'package:ican_project/ui/register/register_bloc.dart';
import 'package:ican_project/ui/register/register_view.dart';
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
        Constant.routeLogin: (context) => Login(),
        Constant.routeRegister: (context) => BlocProvider(create:(context) => RegisterBloc(), child: Register(),),
        Constant.routeWelcome: (context) => Container(),
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,sp){
        if(sp.hasData){
          if(sp.data.getString(Constant.shared_preference_uid) != null){
            CloudService.currentUserUID = sp.data.getString(Constant.shared_preference_uid);
            return Container();
          }
          else return BlocProvider(create:(context) => LoginBloc(), child: Login(),);
        }
        return CircularProgressIndicator();
      },
    );
  }
}

