import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yahalaa/core/utils/constants.dart';
import 'package:yahalaa/features/user/projects/data/models/project_model.dart';
import 'package:yahalaa/features/user/projects/data/repos/project_reop/projects_repo.dart';
part 'all_projects_state.dart';

class AllProjectsCubit extends Cubit<AllProjectsState> {
  AllProjectsCubit(this.projectsRepo) : super(AllProjectsInitial());
  ProjectsRepo? projectsRepo;
  Future<void> allProjectsDetails() async {
    emit(UserAllProjectsLoadingState());
    var result = await projectsRepo!.getAllProjects();
    return result.fold((failure) {
      emit(UserAllProjectsErrorState(failure.errMessage));
    }, (data) {
      emit(UserAllProjectsSuccessState(data));
    });
  }
}
