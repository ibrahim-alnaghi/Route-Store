import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failures, T>> call(Param param);
}
