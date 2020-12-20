import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/ui/result_of_all_tests/roat_event.dart';
import 'package:ican_project/ui/result_of_all_tests/roat_state.dart';
import 'package:ican_project/util/firebase_eception_conveter.dart';

class ROATBloc extends Bloc<ROATEvent,ROATState>{
  ROATBloc() : super(ROATLoadingState());

  @override
  Stream<ROATState> mapEventToState(ROATEvent event) async* {
    // TODO: implement mapEventToState
    if(event is ROATFetchingEvent){
      try {
        double b = await CloudService.getPercentage();
        yield ROATCompleteState(b);
      } on FirebaseException catch (e) {
        // TODO
        yield ROATErrorState(FirebaseExceptionConverter.getErrorMessage(e.code));
      }
    }
  }

}