import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/persist_currencies_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  PersistCurrenciesUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = PersistCurrenciesUseCase(repository);
  });

  group("PersistCurrenciesUseCase tests", () {

    test("shoud persist currencies from repository", () async {
      final currencies = Currencies();
      when(repository.insertCurrencies(currencies)).thenAnswer((_) async => Null);

      final future = usecase.execute(currencies);

      expect(future, completes);
      expectLater(future, completion(Null));
    });
  });

  tearDown(() {
    repository = null;
    usecase = null;
  });
}