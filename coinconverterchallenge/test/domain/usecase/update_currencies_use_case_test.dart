import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_currencies_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  UpdateLocalCurrenciesUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = UpdateLocalCurrenciesUseCase(repository);
  });

  group("UpdateLocalCurrenciesUseCase tests", () {

    test("shoud update currencies from repository", () async {
      final currencies = Currencies();

      final result = await usecase.execute(currencies);

      verifyInOrder([repository.deleteCurrencies(), repository.insertCurrencies(currencies)]);
    });
  });

  tearDown(() {
    repository = null;
    usecase = null;
  });
}