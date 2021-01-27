import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';

class UpdateLocalQuotesUseCase {

  Repository _repository;

  UpdateLocalQuotesUseCase(this._repository);

  Future execute(Quotes quotes) async {
    await _repository.deleteQuotes();
    await _repository.insertQuotes(quotes);
  }
}
