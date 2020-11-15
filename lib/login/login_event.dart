import 'package:equatable/equatable.dart';

abstract class LoginEvent{
  const LoginEvent();
}

class LoginWithEmailAndPassword extends LoginEvent implements Equatable{
  final String email;
  final String password;
  const LoginWithEmailAndPassword(this.email, this.password);

  @override
  // TODO: implement props
  List<Object> get props => [email,password];
  @override
  // TODO: implement stringify
  bool get stringify => true;
}

