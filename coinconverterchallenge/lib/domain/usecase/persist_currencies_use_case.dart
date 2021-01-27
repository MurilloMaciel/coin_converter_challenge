import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';

class PersistCurrenciesUseCase {

  Repository _repository;

  PersistCurrenciesUseCase(this._repository);

  Future execute(Currencies currencies) async => await _repository.insertCurrencies(currencies);
}
