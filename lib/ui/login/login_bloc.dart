import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';

import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{
  FirebaseAuth _auth;

  LoginBloc() : super(LoginInitialState()){
    _auth = FirebaseAuth.instance;
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginWithEmailAndPassword){
      try {
        yield LoginLoadingState();
        var userCredential =  await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        await CloudService.getCurrentUserInFormation(userCredential.user.uid);
        yield LoginCompleteState();
      } on FirebaseAuthException catch (e) {
        // TODO
        yield LoginErrorState(e.code);
      }
    }
  }
}
