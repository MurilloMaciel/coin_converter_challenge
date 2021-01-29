import 'package:coinconverterchallenge/core/network/constants.dart';
import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/core/network/model/http_method.dart';
import 'package:coinconverterchallenge/core/network/model/request.dart';
import 'package:coinconverterchallenge/data/datasource/remote_datasource.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';

class RemoteDataSourceImpl extends RemoteDatasource {

  @override
  Future<Either<ErrorResponse, CurrenciesData>> getAllCurrencies() async {
    final request = Request(HttpMethod.GET, GET_CURRENCIES_URL);
    final result = await request.execute();
    return result.fold((left) {
      return Left(left);
    }, (right) {
      var test = CurrenciesData.fromJson(right.data);
      if (test.privacy != null) {
        return Right(CurrenciesData.fromJson(right.data));
      } else return Left(ErrorResponse.fromJson(right.data));
    });
  }

  @override
  Future<Either<ErrorResponse, QuotesData>> getAllQuotes() async {
    final request = Request(HttpMethod.GET, GET_QUOTES_URL);
    final result = await request.execute();
    return result.fold((left) {
      return Left(left);
    }, (right) {
      var test = CurrenciesData.fromJson(right.data);
      if (test.privacy != null) {
        return Right(QuotesData.fromJson(right.data));
      } else return Left(ErrorResponse.fromJson(right.data));
    });
  }

  @override
  Future<NetworkStatus> checkNetworkStatus() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return NetworkStatus.OFFLINE;
    } else {
      return NetworkStatus.ONLINE;
    }
  }
}