import 'package:coinconverterchallenge/presentation/coins_page/coins_controller.dart';
import 'package:coinconverterchallenge/presentation/conversion_page/conversion_controller.dart';
import 'package:coinconverterchallenge/presentation/splash_page/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/helper/navigation_helper.dart';
import 'core/helper/routes.dart';
import 'di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Di.init();
  runApp(MyChallengeApp());
}

class MyChallengeApp extends StatelessWidget {

  final _theme = ThemeData(
      splashColor: Colors.white,
      primaryColor: Colors.deepPurpleAccent,
      primaryColorDark: Colors.deepPurple,
      accentColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textSelectionColor: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<SplashController>(create: (context) => Di.getSplashController()),
          ChangeNotifierProvider<CoinsController>.value(value: Di.getCoinsController()),
          ChangeNotifierProvider<ConversionController>.value(value: Di.getConversionController()),
        ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Di.getIt.get<NavigationHelper>().navigatorKey,
          title: 'Coin Converter Challenge',
          theme: _theme,
          routes: Routes.routes(),
          initialRoute: Routes.INITIAL_ROUTE,
      ),
    );
  }
}

