import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yahalaa/features/sessions/data/models/session_evaluation_model.dart';
import 'package:yahalaa/features/user/projects/data/models/evaluation_responce_model.dart';
import '../../../data/models/session_evaluation_responce_model.dart';
import '../../../data/repos/sessions_repo/sessions_repo.dart';
part 'get_session_evaluation_state.dart';

class GetSessionEvaluationCubit extends Cubit<GetSessionEvaluationState> {
  GetSessionEvaluationCubit(this.sessionsRepo)
      : super(GetSessionEvaluationInitial());
  SessionsRepo? sessionsRepo;
  Future<void> getSessionEvaluationDetails() async {
    emit(UserGetSessionEvaluationLoadingState());
    var result = await sessionsRepo!.getSessionsEvaluations();
    return result.fold((failure) {
      emit(UserGetSessionEvaluationErrorState(failure.errMessage));
    }, (data) {
      emit(UserGetSessionEvaluationSuccessState(data));
    });
  }
}
