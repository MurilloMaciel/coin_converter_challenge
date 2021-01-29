import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:dartz/dartz.dart';

abstract class LocalDatasource {

  Future insertQuotes(QuotesData quotes);

  Future insertCurrencies(CurrenciesData currencies);

  Future<Either<AccessError, QuotesData>> getQuotes();

  Future<Either<AccessError, CurrenciesData>> getCurrencies();

  Future deleteQuotes();

  Future deleteCurrencies();
}