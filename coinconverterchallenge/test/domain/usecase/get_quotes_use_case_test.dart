import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/core/network/model/api_error.dart';
import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/check_network_status_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_quotes_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}
class CheckNetworkStatusUseCaseMock extends Mock implements CheckNetworkStatusUseCase {}
class GetLocalCurrenciesUseCaseMock extends Mock implements GetLocalCurrenciesUseCase {}
class UpdateLocalCurrenciesUseCaseMock extends Mock implements UpdateLocalCurrenciesUseCase {}

main() {

  Repository repository;
  AccessError accessError;
  Quotes quotes;
  GetQuotesUseCase getQuotesUseCase;
  CheckNetworkStatusUseCase checkNetworkStatusUseCase;
  GetLocalQuotesUseCase getLocalQuotesUseCase;
  UpdateLocalQuotesUseCase updateLocalQuotesUseCase;

  setUp(() {
    accessError = AccessError("error");
    quotes = Quotes();
    repository = RepositoryImplMock();
    checkNetworkStatusUseCase = CheckNetworkStatusUseCase(repository);
    getLocalQuotesUseCase = GetLocalQuotesUseCase(repository);
    updateLocalQuotesUseCase = UpdateLocalQuotesUseCase(repository);
    getQuotesUseCase = GetQuotesUseCase(repository, checkNetworkStatusUseCase, getLocalQuotesUseCase, updateLocalQuotesUseCase);
  });

  group("GetQuotesUseCase tests", () {

    test("shoud get quotes from repository when device has internet access", () async {
      when(repository.getAllQuotes()).thenAnswer((_) async => Right(quotes));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.ONLINE);

      final result = await getQuotesUseCase.execute();

      verify(updateLocalQuotesUseCase.execute(quotes)).called(1);
      expect(result, isA<Right>());
      expect(result.getOrElse(() => null), quotes);
    });

    test("shoud get quotes from repository when device has no internet access", () async {
      when(repository.getQuotes()).thenAnswer((_) async => Right(quotes));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.OFFLINE);

      final result = await getQuotesUseCase.execute();

      verifyNever(updateLocalQuotesUseCase.execute(quotes));
      expect(result, isA<Right>());
      expect(result.getOrElse(() => null), quotes);
    });

    test("shoud return an ErrorResponse from repository when device has internet access an error occurred", () async {
      final errorResponse  = ErrorResponse(success: false, error: ApiError(info: accessError.message, code: 0));
      when(repository.getAllQuotes()).thenAnswer((_) async => Left(errorResponse));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.ONLINE);

      final result = await getQuotesUseCase.execute();

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ErrorResponse>());
      expect(result.fold((l) => l, (r) => r), errorResponse);
    });

    test("shoud return an ErrorResponse from repository when device has no internet access and cant access DB to return quotes", () async {
      final errorResponse  = ErrorResponse(success: false, error: ApiError(info: accessError.message, code: 0));
      when(repository.getQuotes()).thenAnswer((_) async => Left(accessError));
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.OFFLINE);

      final result = await getQuotesUseCase.execute();

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ErrorResponse>());
      expect(result.fold((l) => l.error.info, (r) => r), errorResponse.error.info);
    });
  });

  tearDown(() {
    accessError = null;
    quotes = null;
    repository = null;
    checkNetworkStatusUseCase = null;
    getLocalQuotesUseCase = null;
    updateLocalQuotesUseCase = null;
    getQuotesUseCase = null;
  });
}