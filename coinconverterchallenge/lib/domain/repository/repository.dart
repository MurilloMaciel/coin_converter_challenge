import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {

  Future<NetworkStatus> checkNetworkStatus();

  Future<Either<Currencies, ErrorResponse>> getAllCurrencies();

  Future<Either<Quotes, ErrorResponse>> getAllQuotes();

  Future insertQuotes(Quotes quotes);

  Future insertCurrencies(Currencies currencies);

  Future<Either<Quotes, AccessError>> getQuotes();

  Future<Either<Currencies, AccessError>> getCurrencies();

  Future deleteQuotes();

  Future deleteCurrencies();
}