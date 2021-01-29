import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/delete_quotes_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  DeleteQuotesUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = DeleteQuotesUseCase(repository);
  });

  group("DeleteQuotesUseCase tests", () {

    test("shoud delete quotes from repository", () async {
      when(repository.deleteQuotes()).thenAnswer((_) async => Null);

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