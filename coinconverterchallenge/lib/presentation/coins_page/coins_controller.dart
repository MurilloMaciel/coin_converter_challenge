import 'package:coinconverterchallenge/core/helper/navigation_helper.dart';
import 'package:coinconverterchallenge/core/helper/routes.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/domain/usecase/get_currencies_use_case.dart';
import 'package:coinconverterchallenge/presentation/model/coins_filter.dart';
import 'package:coinconverterchallenge/presentation/model/conversion_page_arguments.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class CoinsController extends ChangeNotifier {

  CoinsController(this._getCurrenciesUseCase);

  GetCurrenciesUseCase _getCurrenciesUseCase;

  Currencies currencies;

  CoinsFilter filter = CoinsFilter.CURRENCY;

  Future getCurrencies() async {
    final result = await _getCurrenciesUseCase.execute();
    return result.fold((left) => left, (right) {
      currencies = right;
      currencies.currencies = _order(right.currencies);
      return currencies;
    });
  }

  Map<String, String> _order(Map<String, String> currencies) {
    if (filter == CoinsFilter.CURRENCY) {
      return _orderByCoinCode(currencies);
    } else {
      return _orderByCoinName(currencies);
    }
  }

  Map<String, String> _orderByCoinCode(Map<String, String> currencies) {
    var temp = Map<String, String>();
    final currencyKeys = List.from(currencies.keys);
    final currencyName = List.from(currencies.values);

    currencyKeys.sort((a, b) => a.compareTo(b));

    for (var value in currencyKeys) {
      if (currencyName.contains(currencies[value])) {
        temp.addAll({value: currencyName.firstWhere((element) => element == currencies[value])});
      }
    }
    return temp;
  }

  Map<String, String> _orderByCoinName(Map<String, String> currencies) {
    var temp = Map<String, String>();
    final currencyKeys = List.from(currencies.keys);
    final currencyName = List.from(currencies.values);

    currencyName.sort((a, b) => a.compareTo(b));

    for (var name in currencyName) {
      String key = "";
      if (currencies.containsValue(name)) {
        for (var entry in currencies.entries) {
          if (entry.value == name) {
            key = entry.key;
            break;
          }
        }
      }
      temp.addAll({key: name});
    }
    return temp;
  }

  void onTapCurrency(String keyTapped) {
    GetIt.instance.get<NavigationHelper>().goTo(
        Routes.CONVERSION_ROUTE,
        arguments: ConversionPageArguments(currencies.currencies, keyTapped)
    );
  }

  void onPressedGoToAbout() {
    GetIt.instance.get<NavigationHelper>().goTo(Routes.ABOUT_ROUTE);
  }

  void setFilterType(CoinsFilter filter) {
    this.filter = filter;
    notifyListeners();
  }
}