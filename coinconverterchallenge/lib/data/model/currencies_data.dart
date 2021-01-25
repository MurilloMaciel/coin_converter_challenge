import 'package:coinconverterchallenge/domain/model/currencies.dart';

class CurrenciesData {

  bool success;
  String terms;
  String privacy;
  Map<String, String> currencies;

  CurrenciesData({this.success, this.terms, this.privacy, this.currencies});

  factory CurrenciesData.fromJson(Map<String, dynamic> json) => CurrenciesData(
    success: json["success"],
    terms: json["terms"],
    privacy: json["privacy"],
    currencies: (json['currencies'] as Map<String, dynamic>)?.map((k, e) => MapEntry(k, e as String),),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "terms": terms,
    "privacy": privacy,
    'currencies': currencies,
  };
}

extension CurrenciesDataExtension on CurrenciesData {
  Currencies mapToCurrencies() => Currencies(
    success: this.success,
    terms: this.terms,
    privacy: this.privacy,
    currencies: Map<String, String>.from(this.currencies),
  );
}

extension CurrenciesExtension on Currencies {
  CurrenciesData mapToCurrenciesData() => CurrenciesData(
    success: this.success,
    terms: this.terms,
    privacy: this.privacy,
    currencies: this.currencies,
  );
}