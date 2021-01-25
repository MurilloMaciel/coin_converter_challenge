import 'package:coinconverterchallenge/domain/model/quotes.dart';

class QuotesData {

  bool success;
  String terms;
  String privacy;
  int timestamp;
  String source;
  Map<String, double> quotes;

  QuotesData({this.success, this.terms, this.privacy, this.timestamp, this.source, this.quotes});

  factory QuotesData.fromJson(Map<String, dynamic> json) => QuotesData(
    success: json["success"],
    terms: json["terms"],
    privacy: json["privacy"],
    timestamp: json["timestamp"],
    source: json["source"],
    quotes: (json['quotes'] as Map<String, dynamic>)?.map((k, e) => MapEntry(k, (e as num)?.toDouble()),),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "terms": terms,
    "privacy": privacy,
    "timestamp": timestamp,
    "source": source,
    "currencies": quotes,
  };
}

extension QuotesDataExtension on QuotesData {
  Quotes mapToQuotes() => Quotes(
    success: this.success,
    terms: this.terms,
    privacy: this.privacy,
    timestamp: this.timestamp,
    source: this.source,
    quotes: Map<String, double>.from(this.quotes),
  );
}

extension QuotesExtension on Quotes {
  QuotesData mapToQuotesData() => QuotesData(
    success: this.success,
    terms: this.terms,
    privacy: this.privacy,
    timestamp: this.timestamp,
    source: this.source,
    quotes: this.quotes,
  );
}