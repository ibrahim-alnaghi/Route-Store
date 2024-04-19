import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class UseCase<Type> {
  Future<Either<Failures, Type>> call();
}
