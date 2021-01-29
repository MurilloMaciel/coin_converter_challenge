import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_currencies_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  GetLocalCurrenciesUseCase usecase;
  Currencies currencies;
  AccessError accessError;

  setUp(() {
    accessError = AccessError("error");
    currencies = Currencies();
    repository = RepositoryImplMock();
    usecase = GetLocalCurrenciesUseCase(repository);
  });

  group("GetLocalCurrenciesUseCase tests", () {

    test("shoud get currencies from repository", () async {
      when(repository.getCurrencies()).thenAnswer((_) async => Right(currencies));

      final result = await usecase.execute();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => null), currencies);
    });

    test("shoud return access error from repository if an error occurred into db access", () async {
      when(repository.getCurrencies()).thenAnswer((_) async => Left(accessError));

      final result = await usecase.execute();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), accessError);
    });
  });

  tearDown(() {
    accessError = null;
    currencies = null;
    repository = null;
    usecase = null;
  });
}