import 'package:coinconverterchallenge/domain/usecase/calculate_coin_conversion_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

main() {

  String valueFrom = "";
  String currencyFrom = "";
  String currencyTo = "";
  Map<String, double> quotes = {
    "USDBRL": 5,
    "USDAUD": 2,
  };
  CalculateCoinConversionUseCase usecase;

  setUp(() {
    usecase = CalculateCoinConversionUseCase();
  });

  group("CalculateCoinConversionUseCase tests", () {

    test("shoud convert from USD", () async {
      valueFrom = "10";
      currencyFrom = "USD";
      currencyTo = "BRL";

      final result = usecase.execute(valueFrom, currencyFrom, currencyTo, quotes);

      expect(result, "50.00");
    });

    test("shoud convert to USD", () async {
      valueFrom = "10";
      currencyFrom = "BRL";
      currencyTo = "USD";

      final result = usecase.execute(valueFrom, currencyFrom, currencyTo, quotes);

      expect(result, "2.00");
    });

    test("shoud convert passing through USD", () async {
      valueFrom = "10";
      currencyFrom = "AUD";
      currencyTo = "BRL";

      final result = usecase.execute(valueFrom, currencyFrom, currencyTo, quotes);

      expect(result, "25.00");
    });
  });

  tearDown(() {
    valueFrom = null;
    currencyFrom = null;
    currencyTo = null;
    usecase = null;
  });
}