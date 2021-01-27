import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/api_error.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/check_network_status_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_quotes_use_case.dart';
import 'package:dartz/dartz.dart';

class GetQuotesUseCase {

  Repository _repository;
  CheckNetworkStatusUseCase _checkNetworkStatusUseCase;
  GetLocalQuotesUseCase _getLocalQuotesUseCase;
  UpdateLocalQuotesUseCase _updateLocalQuotesUseCase;

  GetQuotesUseCase(
    this._repository,
    this._checkNetworkStatusUseCase,
    this._getLocalQuotesUseCase,
    this._updateLocalQuotesUseCase
  );

  Future<Either<Quotes, ErrorResponse>> execute() async {
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

  Future<Either<Quotes, ErrorResponse>> _executeWithNetworkOnline() async {
    final result = await _repository.getAllQuotes();
    return result.fold(
        (left) async {
          await _updateLocalQuotesUseCase.execute(left);
          return Left(left);
        },
        (right) {
          return Right(right);
        }
    );
  }

  Future<Either<Quotes, ErrorResponse>> _executeWithNetworkOffline() async {
    final result = await _getLocalQuotesUseCase.execute();
    return result.fold(
        (left) {
          return Left(left);
        },
        (right) {
          return Right(ErrorResponse(
            success: false,
            error: ApiError(
              code: 0,
              info: right.message
            )
          ));
        }
    );
  }
}