import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/data/datasource/local_datasource.dart';
import 'package:coinconverterchallenge/data/datasource/remote_datasource.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {

  RemoteDatasource _remoteDatasource;
  LocalDatasource _localDatasource;

  RepositoryImpl(this._remoteDatasource, this._localDatasource);

  @override
  Future<NetworkStatus> checkNetworkStatus() async => await _remoteDatasource.checkNetworkStatus();

  @override
  Future<Either<ErrorResponse, Currencies>> getAllCurrencies() async {
    final result = await _remoteDatasource.getAllCurrencies();
    return result.fold((left) => Left(left), (right) => Right(right.mapToCurrencies()));
  }

  @override
  Future<Either<ErrorResponse, Quotes>> getAllQuotes() async {
    final result = await _remoteDatasource.getAllQuotes();
    return result.fold((left) => Left(left), (right) => Right(right.mapToQuotes()));
  }

  @override
  Future<Either<AccessError, Currencies>> getCurrencies() async {
    final result = await _localDatasource.getCurrencies();
    return result.fold((l) => Left(l), (r) => Right(r.mapToCurrencies()));
  }

  @override
  Future<Either<AccessError, Quotes>> getQuotes() async {
    final result = await _localDatasource.getQuotes();
    return result.fold((l) => Left(l), (r) => Right(r.mapToQuotes()));
  }

  @override
  Future insertCurrencies(Currencies currencies) async => await _localDatasource.insertCurrencies(currencies.mapToCurrenciesData());

  @override
  Future insertQuotes(Quotes quotes) async => await _localDatasource.insertQuotes(quotes.mapToQuotesData());

  @override
  Future deleteCurrencies() async  => await _localDatasource.deleteCurrencies();

  @override
  Future deleteQuotes() async  => await _localDatasource.deleteQuotes();
}