import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDatasource {

  Future<Either<CurrenciesData, ErrorResponse>> getAllCurrencies();

  Future<Either<QuotesData, ErrorResponse>> getAllQuotes();

  Future<NetworkStatus> checkNetworkStatus();
}