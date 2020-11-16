import 'package:equatable/equatable.dart';

abstract class RegisterState{
  const RegisterState();
}

class RegisterLoadingState extends RegisterState{
  const RegisterLoadingState();
}

class InitialRegisterState extends RegisterState{
  const InitialRegisterState();
}

class RegisterSuccessfulState extends RegisterState{
  const RegisterSuccessfulState();
}

class RegisterErrorState extends RegisterState implements Equatable{
  final String error;

  const RegisterErrorState(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}