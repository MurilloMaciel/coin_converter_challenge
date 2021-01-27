import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';

class PersistQuotesUseCase {

  Repository _repository;

  PersistQuotesUseCase(this._repository);

  Future execute(Quotes quotes) async => await _repository.insertQuotes(quotes);
}
