import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrenciesUseCase {

  Repository _repository;

  GetCurrenciesUseCase(this._repository);

  Future<Either<Currencies, ErrorResponse>> execute() async {
    final result = await _repository.getAllCurrencies();
    return result.fold((left) => Left(left), (right) => Right(right));
  }
}