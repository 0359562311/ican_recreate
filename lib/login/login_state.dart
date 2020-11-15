import 'package:equatable/equatable.dart';

abstract class LoginState{
  const LoginState();
}

class LoginLoadingState extends LoginInitialState{
  const LoginLoadingState();
}

class LoginInitialState extends LoginState{
  const LoginInitialState();
}

class LoginCompleteState extends LoginState{
  const LoginCompleteState();
}

class LoginErrorState extends LoginState implements Equatable{
  final String errorMessage;
  const LoginErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}