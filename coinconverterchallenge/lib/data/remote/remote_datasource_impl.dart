import 'package:coinconverterchallenge/core/network/constants.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/core/network/model/http_method.dart';
import 'package:coinconverterchallenge/core/network/model/request.dart';
import 'package:coinconverterchallenge/data/datasource/remote_datasource.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:dartz/dartz.dart';

class RemoteDataSourceImpl extends RemoteDatasource {

  @override
  Future<Either<CurrenciesData, ErrorResponse>> getAllCurrencies() async {
    final request = Request(HttpMethod.GET, GET_CURRENCIES_URL);
    final result = await request.execute();
    return result.fold((left) {
      var test = CurrenciesData.fromJson(left.data);
      if (test.privacy != null) {
        return Left(CurrenciesData.fromJson(left.data));
      } else return Right(ErrorResponse.fromJson(left.data));
    }, (right) => Right(right));
  }

  @override
  Future<Either<QuotesData, ErrorResponse>> getAllQuotes() async {
    final request = Request(HttpMethod.GET, GET_QUOTES_URL);
    final result = await request.execute();
    return result.fold((left) {
      var test = CurrenciesData.fromJson(left.data);
      if (test.privacy != null) {
        return Left(QuotesData.fromJson(left.data));
      } else return Right(ErrorResponse.fromJson(left.data));
    }, (right) => Right(right));
  }
}