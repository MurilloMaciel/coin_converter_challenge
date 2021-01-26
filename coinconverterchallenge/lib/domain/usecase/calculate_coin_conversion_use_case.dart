import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class CalculateCoinConversionUseCase {

  String execute(String valueFrom, String currencyFrom, String currencyTo, Map<String, double> quotes) {
    if (currencyFrom == "USD") {
      return _calculateFromUsd(valueFrom, currencyTo, quotes);
    } else if (currencyTo == "USD") {
      return _calculateToUsd(valueFrom, currencyFrom, quotes);
    } else {
      return _calculateFromOtherCurrencyFrom(valueFrom, currencyFrom, currencyTo, quotes);
    }
  }

  String _calculateFromUsd(String valueFrom, String currencyTo, Map<String, double> quotes) {
    final quote = quotes["USD$currencyTo"];
    final double valueToCalculate = double.parse(valueFrom);
    final result = valueToCalculate * quote;
    return result.toStringAsFixed(2);
  }

  String _calculateToUsd(String valueFrom, String currencyFrom, Map<String, double> quotes) {
    final quote = quotes["USD$currencyFrom"];
    final double valueToCalculate = double.parse(valueFrom);
    final result = valueToCalculate / quote;
    return result.toStringAsFixed(2);
  }

  String _calculateFromOtherCurrencyFrom(String valueFrom, String currencyFrom, String currencyTo, Map<String, double> quotes) {
    final quoteUsd = quotes["USD$currencyFrom"];
    final quoteCurrencyTo = quotes["USD$currencyTo"];
    final double valueToCalculate = double.parse(valueFrom);
    final double valueToUsd = valueToCalculate / quoteUsd;
    final double finalValue = valueToUsd * quoteCurrencyTo;
    // sll to aud
    if (finalValue < 0.001) {
      return finalValue.toStringAsExponential(2);
    }
    return finalValue.toStringAsFixed(2);
  }
}