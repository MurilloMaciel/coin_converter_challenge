import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/data/dao/currencies_dao.dart';
import 'package:coinconverterchallenge/data/dao/quotes_dao.dart';
import 'package:coinconverterchallenge/data/datasource/local_datasource.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:dartz/dartz.dart';

class LocalDatasourceImpl implements LocalDatasource {

  @override
  Future<Either<AccessError, CurrenciesData>> getCurrencies() async {
    final result = await CurrenciesDao().retrieveAll();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<AccessError, QuotesData>> getQuotes() async {
    final result = await QuotesDao().retrieveAll();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future insertCurrencies(CurrenciesData currencies) async => await CurrenciesDao().insert(currencies);

  @override
  Future insertQuotes(QuotesData quotes) async => await QuotesDao().insert(quotes);

  @override
  Future deleteCurrencies() async  => await CurrenciesDao().deleteAll();

  @override
  Future deleteQuotes() async  => await QuotesDao().deleteAll();
}