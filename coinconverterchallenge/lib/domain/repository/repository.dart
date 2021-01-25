import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {

  Future<Either<Currencies, ErrorResponse>> getAllCurrencies();

  Future<Either<Quotes, ErrorResponse>> getAllQuotes();
}