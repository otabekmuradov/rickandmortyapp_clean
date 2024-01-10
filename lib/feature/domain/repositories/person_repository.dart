import 'package:dartz/dartz.dart';
import 'package:rickandmortyapp/core/error/failure.dart';
import 'package:rickandmortyapp/feature/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
