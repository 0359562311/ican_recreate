import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/register/register_event.dart';
import 'package:ican_project/register/register_state.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  FirebaseAuth _auth;

  RegisterBloc() : super(InitialRegisterState()){
    _auth = FirebaseAuth.instance;
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if(event is RegisterInitEvent){
      yield InitialRegisterState();
    }else if(event is RegisterWithEmailAndPasswordEvent){
      yield RegisterLoadingState();
      try {
        await _auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
      } on FirebaseAuthException catch (e) {
        // TODO
        yield RegisterErrorState(FirebaseExceptionConverter.getErrorMessage(e.code));
      }
    }
  }

}