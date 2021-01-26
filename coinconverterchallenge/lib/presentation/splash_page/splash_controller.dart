import 'package:coinconverterchallenge/core/helper/navigation_helper.dart';
import 'package:coinconverterchallenge/core/helper/routes.dart';
import 'package:get_it/get_it.dart';

class SplashController {

  final _splashTime = 2000;

  void goToCoinsPage() {
    Future.delayed(Duration(milliseconds: _splashTime)).then((_) {
      GetIt.instance.get<NavigationHelper>().replace(Routes.COINS_ROUTE);
    });
  }
}