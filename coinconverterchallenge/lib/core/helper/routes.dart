import 'package:coinconverterchallenge/presentation/coins_page/coins_page.dart';
import 'package:coinconverterchallenge/presentation/conversion_page/conversion_page.dart';
import 'package:coinconverterchallenge/presentation/test/test.dart';
import 'package:flutter/material.dart';

class Routes {

  static const String TEST_ROUTE = "/test";
  static const String COINS_ROUTE = "/coins";
  static const String CONVERSION_ROUTE = "/conversion";

  static const String INITIAL_ROUTE = TEST_ROUTE;

  static Map<String, WidgetBuilder> routes() => {
    TEST_ROUTE: (BuildContext context) => Test(),
    COINS_ROUTE: (BuildContext context) => CoinsPage(),
    CONVERSION_ROUTE: (BuildContext context) => ConversionPage(),
  };
}