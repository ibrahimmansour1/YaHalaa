import 'package:dartz/dartz.dart';
import 'package:yahalaa/core/errors/failure.dart';
import 'package:yahalaa/features/user/projects/data/models/evaluation_project_model.dart';
import 'package:yahalaa/features/user/projects/data/models/evaluation_responce_model.dart';
import 'package:yahalaa/features/user/projects/data/models/project_model.dart';

abstract class ProjectsRepo {
  Future<Either<Failure, ProjectModel>> getAllProjects();
  Future<Either<Failure, EvaluationProjectModel>> getProjectEvaluations();
  Future<Either<Failure, EvaluationResponseModel>> postProjectEvaluations(
      {required var data});
}
