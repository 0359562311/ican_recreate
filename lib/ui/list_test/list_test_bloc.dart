import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/ui/list_test/list_test_event.dart';
import 'package:ican_project/ui/list_test/list_test_state.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';

class ListTestBloc extends Bloc<ListTestEvent, ListTestState>{
  ListTestBloc() : super(ListTestInitState());

  @override
  Stream<ListTestState> mapEventToState(ListTestEvent event) async* {
    // TODO: implement mapEventToState
    if(event is ListTestGetAllTests){
      try {
        yield ListTestLoading();
        List<bool> items = await CloudService.getDoneOrNot(event.subject,event.grade);
        yield ListTestLoadedState(items);
      } on FirebaseException catch (e) {
        // TODO
        yield ListTestErrorState(FirebaseExceptionConverter.getErrorMessage(e.code));
      } on Exception catch (e){
        yield ListTestErrorState(e.toString());
      }
    }
  }

}