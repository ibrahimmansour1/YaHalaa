import 'package:dartz/dartz.dart';
import 'package:yahalaa/core/errors/failure.dart';
import '../../models/book_model.dart';
import '../../models/session_evaluation_model.dart';
import '../../models/session_evaluation_responce_model.dart';
import '../../models/sessions_model.dart';
import '../../models/specific_session_model.dart';

abstract class SessionsRepo {
  Future<Either<Failure, SessionsModel>> getAllSessions(
      {Map<String, dynamic>? query});
  Future<Either<Failure, SessionsModel>> getSubscribedSessions(
      {Map<String, dynamic>? query});
  Future<Either<Failure, SpecificSessionModel>> getSpecificSession(
      {required int id});
  Future<Either<Failure, BookModel>> bookSession({required int id});
  Future<Either<Failure, BookModel>> cancelBookSession({required int id});
  Future<Either<Failure, SessionEvaluationResponseModel>>
      postSessionsEvaluations({required var data});
  Future<Either<Failure, SessionEvaluationModel>> getSessionsEvaluations();
}
