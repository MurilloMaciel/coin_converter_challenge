import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class CalculateCoinConversionUseCase {

  String execute(String valueFrom, String currencyFrom, String currencyTo, Map<String, double> quotes) {

    final double valueToCalculate = double.parse(valueFrom);
    double result;
    if (currencyFrom == "USD") {
      result = _calculateFromUsd(valueToCalculate, quotes["USD$currencyTo"]);
    } else if (currencyTo == "USD") {
      result = _calculateToUsd(valueToCalculate, quotes["USD$currencyFrom"]);
    } else {
      result = _calculateFromOtherCurrencyFrom(valueToCalculate, quotes["USD$currencyFrom"], quotes["USD$currencyTo"]);
    }
    return result.toStringAsFixed(2);
  }

  double _calculateFromUsd(double valueToCalculate, double quote) => valueToCalculate * quote;

  double _calculateToUsd(double valueToCalculate, double quote) => valueToCalculate / quote;

  double _calculateFromOtherCurrencyFrom(double valueToCalculate, double quoteUsd, double quoteCurrencyTo) {
    final double valueToUsd = valueToCalculate / quoteUsd;
    final double finalValue = valueToUsd * quoteCurrencyTo;
    if (finalValue < 0.001) {
      return finalValue;
    }
    return finalValue;
  }
}