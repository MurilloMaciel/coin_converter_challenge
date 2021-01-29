import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/persist_quotes_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  PersistQuotesUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = PersistQuotesUseCase(repository);
  });

  group("PersistQuotesUseCase tests", () {

    test("shoud persist quotes from repository", () async {
      final quotes = Quotes();
      when(repository.insertQuotes(quotes)).thenAnswer((_) async => Null);

      final future = usecase.execute(quotes);

      expect(future, completes);
      expectLater(future, completion(Null));
    });
  });

  tearDown(() {
    repository = null;
    usecase = null;
  });
}