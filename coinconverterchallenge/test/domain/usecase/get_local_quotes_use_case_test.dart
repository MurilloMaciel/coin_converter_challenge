import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_quotes_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  GetLocalQuotesUseCase usecase;
  Quotes quotes;
  AccessError accessError;

  setUp(() {
    accessError = AccessError("error");
    quotes = Quotes();
    repository = RepositoryImplMock();
    usecase = GetLocalQuotesUseCase(repository);
  });

  group("GetLocalQuotesUseCase tests", () {

    test("shoud get quotes from repository", () async {
      when(repository.getQuotes()).thenAnswer((_) async => Right(quotes));

      final result = await usecase.execute();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => null), quotes);
    });

    test("shoud return access error from repository if an error occurred into db access", () async {
      when(repository.getQuotes()).thenAnswer((_) async => Left(accessError));

      final result = await usecase.execute();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), accessError);
    });
  });

  tearDown(() {
    accessError = null;
    quotes = null;
    repository = null;
    usecase = null;
  });
}