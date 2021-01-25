import 'package:coinconverterchallenge/presentation/test/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/helper/routes.dart';
import 'di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Di.init();
  runApp(MyChallengeApp());
}

class MyChallengeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TestController>.value(value: Di.getTestController())
        ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Coin Converter BTG',
          theme: ThemeData(),
          routes: Routes.routes(),
          initialRoute: Routes.INITIAL_ROUTE,
      ),
    );
  }
}

