import 'package:coinconverterchallenge/core/network/model/error_response.dart';
import 'package:coinconverterchallenge/core/widgets/icon_info.dart';
import 'package:coinconverterchallenge/core/widgets/loader.dart';
import 'package:coinconverterchallenge/domain/model/currencies.dart';
import 'package:coinconverterchallenge/presentation/coins_page/coins_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinsPage extends StatefulWidget {
  @override
  _CoinsPageState createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage> {

  CoinsController _controller;

  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),
  );

  String _getErrorText(String error) {
    if (error.contains("[")) {
      return error.split("[")[0];
    } else return error;
  }

  @override
  Widget build(BuildContext context) {
    _controller = _controller == null ? Provider.of<CoinsController>(context) : _controller;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) => NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget> [
          SliverAppBar(
            shape: shape,
            stretch: true,
            snap: true,
            primary: true,
            title: Text("Currency Converter"),
            pinned: true,
            floating: true,
            actions: [
              IconButton(icon: Icon(Icons.text_snippet_outlined, color: Colors.white,), onPressed: _controller.onPressedGoToAbout),
              IconButton(icon: Icon(Icons.filter_list_alt, color: Colors.white,), onPressed: null),
            ],
            forceElevated: innerBoxIsScrolled,
            bottom: AppBar(
              elevation: 5,
              shape: shape,
              centerTitle: true,
              title: Text("Coins Available",),
            ),
          )
        ];
      },
      body: _coinsBuilder(context)
  );

  Widget _coinsBuilder(BuildContext context) => FutureBuilder(
    future: _controller.getCurrencies(),
    builder: (context, snapshot) {
      final data = snapshot.data;
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return _errorScreen(context, "System unavailable.");
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Loader();
        case ConnectionState.done:
          if (data is ErrorResponse) {
            return _errorScreen(context, _getErrorText(data.error.info));
          }
          return _coinList(context, data as Currencies);
        default: return Container();
      }
    },
  );

  Widget _errorScreen(BuildContext context, String error) => IconInfo(
      Icons.close,
      Theme.of(context).primaryColorDark,
      Colors.red,
      44,
      "Error: $error"
  );

  Widget _coinList(BuildContext context, Currencies currencies) => ListView.builder(
    itemCount: currencies.currencies.length,
    itemBuilder: (context, index) {
      String key = currencies.currencies.isEmpty ? "" : currencies.currencies.keys.elementAt(index);
      return ListTile(
        onTap: () { _controller.onTapCurrency(key); },
        title: Text(
          key ?? "Undefined",
          style: TextStyle(
            color: Theme.of(context).textSelectionColor
          ),
        ),
        subtitle: Text(
          currencies.currencies[key] ?? "Undefined",
          style: TextStyle(
              color: Theme.of(context).textSelectionColor
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).textSelectionColor,
          size: 18,
        ),
      );
    },
  );
}
