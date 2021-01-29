import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_quotes_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  UpdateLocalQuotesUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = UpdateLocalQuotesUseCase(repository);
  });

  group("UpdateLocalQuotesUseCase tests", () {

    test("shoud update quotes from repository", () async {
      final quotes = Quotes();

      final result = await usecase.execute(quotes);

      verifyInOrder([repository.deleteQuotes(), repository.insertQuotes(quotes)]);
    });
  });

  tearDown(() {
    repository = null;
    usecase = null;
  });
}