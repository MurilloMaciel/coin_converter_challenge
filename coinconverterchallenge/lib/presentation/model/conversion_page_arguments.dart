import 'package:coinconverterchallenge/domain/model/currencies.dart';

class ConversionPageArguments {

  final Map<String, String> currencies;
  final String keyTapped;

  ConversionPageArguments(this.currencies, this.keyTapped);
}