import 'package:dartz/dartz.dart';
import 'package:yahalaa/core/errors/failure.dart';

import '../../models/event_model.dart';

abstract class EventRepo {
  Future<Either<Failure, EventModel>> eventDetails();
}
