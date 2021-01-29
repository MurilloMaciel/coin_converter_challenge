import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/api_error.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/check_network_status_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_currencies_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  AccessError accessError;
  Currencies currencies;
  GetCurrenciesUseCase getCurrenciesUseCase;
  CheckNetworkStatusUseCase checkNetworkStatusUseCase;
  GetLocalCurrenciesUseCase getLocalCurrenciesUseCase;
  UpdateLocalCurrenciesUseCase updateLocalCurrenciesUseCase;

  setUp(() {
    accessError = AccessError("error");
    currencies = Currencies();
    repository = RepositoryImplMock();
    checkNetworkStatusUseCase = CheckNetworkStatusUseCase(repository);
    getLocalCurrenciesUseCase = GetLocalCurrenciesUseCase(repository);
    updateLocalCurrenciesUseCase = UpdateLocalCurrenciesUseCase(repository);
    getCurrenciesUseCase = GetCurrenciesUseCase(repository, checkNetworkStatusUseCase, getLocalCurrenciesUseCase, updateLocalCurrenciesUseCase);
  });

  group("GetCurrenciesUseCase tests", () {

    test("shoud get currencies from repository when device has internet access", () async {
      when(repository.getAllCurrencies()).thenAnswer((_) async => Right(currencies));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.ONLINE);

      final result = await getCurrenciesUseCase.execute();

      verify(updateLocalCurrenciesUseCase.execute(currencies)).called(1);
      expect(result, isA<Right>());
      expect(result.getOrElse(() => null), currencies);
    });

    test("shoud get currencies from repository when device has no internet access", () async {
      when(repository.getCurrencies()).thenAnswer((_) async => Right(currencies));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.OFFLINE);

      final result = await getCurrenciesUseCase.execute();

      verifyNever(updateLocalCurrenciesUseCase.execute(currencies));
      expect(result, isA<Right>());
      expect(result.getOrElse(() => null), currencies);
    });

    test("shoud return an ErrorResponse from repository when device has internet access an error occurred", () async {
      final errorResponse  = ErrorResponse(success: false, error: ApiError(info: accessError.message, code: 0));
      when(repository.getAllCurrencies()).thenAnswer((_) async => Left(errorResponse));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.ONLINE);

      final result = await getCurrenciesUseCase.execute();

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ErrorResponse>());
      expect(result.fold((l) => l, (r) => r), errorResponse);
    });

    test("shoud return an ErrorResponse from repository when device has no internet access and cant access DB to return currencies", () async {
      final errorResponse  = ErrorResponse(success: false, error: ApiError(info: accessError.message, code: 0));
      when(repository.getCurrencies()).thenAnswer((_) async => Left(accessError));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.OFFLINE);

      final result = await getCurrenciesUseCase.execute();

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ErrorResponse>());
      expect(result.fold((l) => l.error.info, (r) => r), errorResponse.error.info);
    });
  });

  tearDown(() {
    accessError = null;
    currencies = null;
    repository = null;
    checkNetworkStatusUseCase = null;
    getLocalCurrenciesUseCase = null;
    updateLocalCurrenciesUseCase = null;
    getCurrenciesUseCase = null;
  });
}