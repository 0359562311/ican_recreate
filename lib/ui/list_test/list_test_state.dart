import 'package:equatable/equatable.dart';

abstract class ListTestState{
  const ListTestState();
}

class ListTestInitState extends ListTestState{}

class ListTestLoading extends ListTestState{
  const ListTestLoading();
}

class ListTestErrorState extends ListTestState{
  final String errorMessage;

  const ListTestErrorState(this.errorMessage);
}

class ListTestLoadedState extends ListTestState implements Equatable{
  final List<bool> listItems;

  const ListTestLoadedState(this.listItems);

  @override
  // TODO: implement props
  List<Object> get props => [listItems];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}