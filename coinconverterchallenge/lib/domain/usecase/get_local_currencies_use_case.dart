import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetLocalCurrenciesUseCase {

  Repository _repository;

  GetLocalCurrenciesUseCase(this._repository);

  Future<Either<AccessError, Currencies>> execute() async => await _repository.getCurrencies();
}
