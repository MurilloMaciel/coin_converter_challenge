import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';

class DeleteQuotesUseCase {

  Repository _repository;

  DeleteQuotesUseCase(this._repository);

  Future execute() async => await _repository.deleteQuotes();
}
