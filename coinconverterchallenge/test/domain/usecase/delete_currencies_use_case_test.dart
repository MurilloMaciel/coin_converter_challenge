import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/delete_currencies_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  DeleteCurrenciesUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = DeleteCurrenciesUseCase(repository);
  });

  group("DeleteCurrenciesUseCase tests", () {

    test("shoud delete currencies from repository", () async {
      when(repository.deleteCurrencies()).thenAnswer((_) async => Null);

      final future = usecase.execute();

      expect(future, completes);
      expectLater(future, completion(Null));
    });
  });

  tearDown(() {
    repository = null;
    usecase = null;
  });
}