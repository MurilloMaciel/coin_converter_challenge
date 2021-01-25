import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/data/datasource/remote_datasource.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {

  RemoteDatasource _remoteDatasource;

  RepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Currencies, ErrorResponse>> getAllCurrencies() async {
    final result = await _remoteDatasource.getAllCurrencies();
    return result.fold((left) => Left(left.mapToCurrencies()), (right) => Right(right));
  }

  @override
  Future<Either<Quotes, ErrorResponse>> getAllQuotes() async {
    final result = await _remoteDatasource.getAllQuotes();
    return result.fold((left) => Left(left.mapToQuotes()), (right) => Right(right));
  }
}