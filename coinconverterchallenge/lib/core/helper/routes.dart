import 'package:coinconverterchallenge/presentation/about_page/about_page.dart';
import 'package:coinconverterchallenge/presentation/coins_page/coins_page.dart';
import 'package:coinconverterchallenge/presentation/conversion_page/conversion_page.dart';
import 'package:coinconverterchallenge/presentation/splash_page/splash_page.dart';
import 'package:flutter/material.dart';

class Routes {

  static const String SPLASH_PAGE = "/splash";
  static const String COINS_ROUTE = "/coins";
  static const String CONVERSION_ROUTE = "/conversion";
  static const String ABOUT_ROUTE = "/about";

  static const String INITIAL_ROUTE = SPLASH_PAGE;

  static Map<String, WidgetBuilder> routes() => {
    SPLASH_PAGE: (BuildContext context) => SplashPage(),
    COINS_ROUTE: (BuildContext context) => CoinsPage(),
    CONVERSION_ROUTE: (BuildContext context) => ConversionPage(),
    ABOUT_ROUTE: (BuildContext context) => AboutPage(),
  };
}