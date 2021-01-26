import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/usecase/get_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_quotes_use_case.dart';
import 'package:flutter/cupertino.dart';

class TestController extends ChangeNotifier {

  TestController(this.usecase, this.usecaseq);

  GetCurrenciesUseCase usecase;
  GetQuotesUseCase usecaseq;

  Future<void> test() async {
    print( ">>>>>>>> vai");
    final result = await usecaseq.execute();
    final test = result.fold((l) => l, (r) => r);
    if (test is Quotes) {

      print( ">>>>>>>> test ${test.success}");
      print( ">>>>>>>> test ${test.quotes}");
    } else {

    }
    print( ">>>>>>>> final use case ${test.toString()}");
  }
}