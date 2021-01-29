import 'package:coinconverterchallenge/domain/repository/repository.dart';

class DeleteCurrenciesUseCase {

  Repository _repository;

  DeleteCurrenciesUseCase(this._repository);

  Future execute() async => await _repository.deleteCurrencies();
}
