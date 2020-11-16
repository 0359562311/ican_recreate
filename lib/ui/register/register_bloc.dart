import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/ui/register/register_event.dart';
import 'package:ican_project/ui/register/register_state.dart';
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
        UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
              email: event.user.email,
              password: event.user.password
          );
        await CloudService.addUserInformation(event.user..uid = credential.user.uid);
        yield RegisterSuccessfulState();
      } on FirebaseAuthException catch (e) {
        // TODO
        yield RegisterErrorState(FirebaseExceptionConverter.getErrorMessage(e.code));
      }
    }
  }

}