import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetQuotesUseCase {

  Repository _repository;

  GetQuotesUseCase(this._repository);

  Future<Either<Quotes, ErrorResponse>> execute() async {
    final result = await _repository.getAllQuotes();
    return result.fold((left) => Left(left), (right) => Right(right));
  }
}