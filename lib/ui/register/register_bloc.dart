import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/ui/register/register_event.dart';
import 'package:ican_project/ui/register/register_state.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{

  RegisterBloc() : super(InitialRegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if(event is RegisterInitEvent){
      yield InitialRegisterState();
    }else if(event is RegisterWithEmailAndPasswordEvent){
      yield RegisterLoadingState();
      try {
        var user = await AuthService.createUser(event.user);
        user.sendEmailVerification();
        yield RegisterSuccessfulState();
      } on FirebaseAuthException catch (e) {
        // TODO
        yield RegisterErrorState(FirebaseExceptionConverter.getErrorMessage(e.code));
      }
    }
  }

}