import 'package:equatable/equatable.dart';
import 'package:ican_project/model/custom_user.dart';

abstract class RegisterEvent{
  const RegisterEvent();
}

class RegisterInitEvent extends RegisterEvent{
  const RegisterInitEvent();
}

class RegisterWithEmailAndPasswordEvent extends RegisterEvent implements Equatable{
  CustomUser user;

  RegisterWithEmailAndPasswordEvent(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}