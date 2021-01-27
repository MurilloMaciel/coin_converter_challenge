import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';

class UpdateLocalCurrenciesUseCase {

  Repository _repository;

  UpdateLocalCurrenciesUseCase(this._repository);

  Future execute(Currencies currencies) async {
    await _repository.deleteCurrencies();
    await _repository.insertCurrencies(currencies);
  }
}
