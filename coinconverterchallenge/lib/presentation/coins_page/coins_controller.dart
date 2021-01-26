import 'package:coinconverterchallenge/core/helper/navigation_helper.dart';
import 'package:coinconverterchallenge/core/helper/routes.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/usecase/get_currencies_use_case.dart';
import 'package:coinconverterchallenge/presentation/model/conversion_page_arguments.dart';
import 'package:get_it/get_it.dart';

class CoinsController {

  CoinsController(this._getCurrenciesUseCase);

  GetCurrenciesUseCase _getCurrenciesUseCase;

  Currencies currencies;

  Future getCurrencies() async {
    final result = await _getCurrenciesUseCase.execute();
    return result.fold((left) {
      currencies = left;
      return left;
    }, (right) => right);
  }

  void onTapCurrency(String keyTapped) {
    GetIt.instance.get<NavigationHelper>().goTo(
        Routes.CONVERSION_ROUTE,
        arguments: ConversionPageArguments(currencies.currencies, keyTapped)
    );
  }
}