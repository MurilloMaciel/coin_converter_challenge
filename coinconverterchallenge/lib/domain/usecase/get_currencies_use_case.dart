import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/api_error.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_currencies_use_case.dart';
import 'package:dartz/dartz.dart';
import 'check_network_status_use_case.dart';

class GetCurrenciesUseCase {

  Repository _repository;
  CheckNetworkStatusUseCase _checkNetworkStatusUseCase;
  GetLocalCurrenciesUseCase _getLocalCurrenciesUseCase;
  UpdateLocalCurrenciesUseCase _updateLocalCurrenciesUseCase;

  GetCurrenciesUseCase(
      this._repository,
      this._checkNetworkStatusUseCase,
      this._getLocalCurrenciesUseCase,
      this._updateLocalCurrenciesUseCase
  );

  Future<Either<ErrorResponse, Currencies>> execute() async {
    if (await _isNetworkOnline()) {
      return await _executeWithNetworkOnline();
    } else {
      return await _executeWithNetworkOffline();
    }
  }

  Future<bool> _isNetworkOnline() async {
    final status = await _checkNetworkStatusUseCase.execute();
    return status == NetworkStatus.ONLINE;
  }

  Future<Either<ErrorResponse, Currencies>> _executeWithNetworkOnline() async {
    final result = await _repository.getAllCurrencies();
    return result.fold(
        (left) {
          return Left(left);
        },
        (right) async {
          await _updateLocalCurrenciesUseCase.execute(right);
          return Right(right);
        }
    );
  }

  Future<Either<ErrorResponse, Currencies>> _executeWithNetworkOffline() async {
    final result = await _getLocalCurrenciesUseCase.execute();
    return result.fold(
        (left) {
          return Left(ErrorResponse(
              success: false,
              error: ApiError(
                  code: 0,
                  info: left.message
              )
          ));
        },
        (right) {
          return Right(right);
        }
    );
  }
}