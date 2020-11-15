import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/login/login_event.dart';
import 'package:ican_project/login/login_state.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{
  FirebaseAuth _auth;

  LoginBloc() : super(LoginInitialState()){
    _auth = FirebaseAuth.instance;
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print("map event $event");
    if(event is LoginWithEmailAndPassword){
      try {
        yield LoginLoadingState();
        var userCredential =  await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        CloudService.currentUserUID = userCredential.user.uid;
        yield LoginCompleteState();
      } on FirebaseAuthException catch (e) {
        // TODO
        yield LoginErrorState(e.code);
      }
    }
  }
}
