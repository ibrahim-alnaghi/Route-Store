import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class UseCase<T> {
  Future<Either<Failures, T>> call();
}
