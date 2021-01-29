import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetLocalQuotesUseCase {

  Repository _repository;

  GetLocalQuotesUseCase(this._repository);

  Future<Either<AccessError, Quotes>> execute() async => await _repository.getQuotes();
}
