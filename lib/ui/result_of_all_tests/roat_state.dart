import 'package:equatable/equatable.dart';

abstract class ROATState{}

// class ROATInitState extends ROATState{}

class ROATLoadingState extends ROATState{}

class ROATCompleteState extends ROATState implements Equatable{
  final double percentage;

  ROATCompleteState(this.percentage);

  @override
  // TODO: implement props
  List<Object> get props => [percentage];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}

class ROATErrorState extends ROATState implements Equatable{
  final String message;

  ROATErrorState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}