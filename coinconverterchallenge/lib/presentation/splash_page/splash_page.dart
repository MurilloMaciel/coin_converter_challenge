import 'package:coinconverterchallenge/core/widgets/icon_info.dart';
import 'package:coinconverterchallenge/presentation/splash_page/splash_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {

  SplashController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = _controller == null ? Provider.of<SplashController>(context) : _controller;
    _controller.goToCoinsPage();
    return Material(child: _body(context));
  }

  Widget _body(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Theme.of(context).splashColor,
    child: IconInfo(
        Icons.account_balance,
        Theme.of(context).primaryColorDark,
        Colors.white,
        30,
        "Coin Converter"
    ),
  );
}
