import 'package:equatable/equatable.dart';

abstract class RegisterEvent{
  const RegisterEvent();
}

class RegisterInitEvent extends RegisterEvent{
  const RegisterInitEvent();
}

class RegisterWithEmailAndPasswordEvent extends RegisterEvent implements Equatable{
  final String email;
  final String password;

  const RegisterWithEmailAndPasswordEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object> get props => [email,password];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}