import 'package:coinconverterchallenge/core/network/model/request_state.dart';
import 'package:coinconverterchallenge/core/network/model/resource.dart';
import 'package:coinconverterchallenge/domain/model/quotes.dart';
import 'package:coinconverterchallenge/domain/usecase/calculate_coin_conversion_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_quotes_use_case.dart';
import 'package:coinconverterchallenge/presentation/model/conversion_page_arguments.dart';
import 'package:flutter/material.dart';

const CONVERSION_VALUE_MAX_LENGHT = 8;

class ConversionController extends ChangeNotifier {

  ConversionController(this._getQuotesUseCase, this._calculateCoinConversionUseCase);

  GetQuotesUseCase _getQuotesUseCase;
  CalculateCoinConversionUseCase _calculateCoinConversionUseCase;

  final key = GlobalKey<ScaffoldState>();

  String valueFrom = "";
  String valueTo = "";

  String currencyFrom;
  String currencyTo;

  List<String> currencies;
  List<String> conversionNameList;
  Map<String, double> quotes;

  Resource resource = Resource(RequestState.LOADING);

  bool _alreadyGetQuotes = false;

  void _showError(String error) {
    key.currentState.showSnackBar(SnackBar(
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(error, style: TextStyle(fontSize: 16),),
      ),
      action: SnackBarAction(onPressed: (){}, label: "ENTENDI",),
      backgroundColor: Colors.redAccent,
      duration: Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.fixed,
    ));
  }

  Future getQuotes({bool force = false}) async {
    if (!_canGetQuotes(force)) {
      return;
    }
    _alreadyGetQuotes = true;
    resource.setLoading();
    notifyListeners();
    final result = await _getQuotesUseCase.execute();
    result.fold((left) {
      quotes = left.quotes; // cada key começa com USD -> USDAED
      conversionNameList = List.from(left.quotes.keys);
      resource.setSuccess();
      notifyListeners();
    }, (right) {
      resource.setError(right.error.info, code: right.error.code);
      notifyListeners();
    });
  }

  bool _canGetQuotes(bool force) => force || !_alreadyGetQuotes;

  void onReceiveArgs(ConversionPageArguments args) {
    currencies = currencies == null ? List.from(args.currencies.keys) : currencies;
    currencyFrom = currencyFrom == null ? args.keyTapped : currencyFrom;
    currencyTo = currencyTo == null ? currencies[0] : currencyTo;
  }

  void setValueConversionFrom(String value) {
    valueFrom = value;
    notifyListeners();
  }

  void onPressedEraseOneNumber() {
    if (valueFrom.isNotEmpty) {
      setValueConversionFrom(valueFrom.substring(0, valueFrom.length-1));
    }
  }

  void onPressedNumber(String number) {
    if (valueFrom.length <= CONVERSION_VALUE_MAX_LENGHT) {
      setValueConversionFrom(valueFrom + number);
    }
  }


  void onPressedDone() {
    if (valueFrom.isEmpty || double.parse(valueFrom) <= 0) {
      _showError("Conversion value needed");
      return;
    }
    final result = _calculateCoinConversionUseCase.execute(valueFrom, currencyFrom, currencyTo, quotes);
    if (result.isEmpty || double.parse(result) < 0) {
      _showError("An error occurred, please try again");
      return;
    }
    valueTo = result;
    notifyListeners();
  }

  void onChangeCoinFrom(String coinFrom) {
    this.currencyFrom = coinFrom;
    notifyListeners();
  }

  void onChangeCoinTo(String coinTo) {
    this.currencyTo = coinTo;
    notifyListeners();
  }
}