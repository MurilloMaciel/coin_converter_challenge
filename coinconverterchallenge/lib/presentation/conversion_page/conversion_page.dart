import 'package:coinconverterchallenge/core/network/model/request_state.dart';
import 'package:coinconverterchallenge/core/widgets/icon_info.dart';
import 'file:///E:/repos/btg_coin_conversion/coin_converter_challenge/coinconverterchallenge/lib/presentation/conversion_page/widgets/keyboard.dart';
import 'package:coinconverterchallenge/core/widgets/loader.dart';
import 'package:coinconverterchallenge/presentation/conversion_page/conversion_controller.dart';
import 'package:coinconverterchallenge/presentation/model/conversion_page_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversionPage extends StatefulWidget {

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {

  ConversionPageArguments args;

  ConversionController _controller;

  double height;

  void _initialSetup() {
    args = args == null ? ModalRoute.of(context).settings.arguments : args;
    _controller = _controller == null ? Provider.of<ConversionController>(context) : _controller;
    _controller.onReceiveArgs(args);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.getQuotes());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    _initialSetup();
    return Scaffold(
      key: _controller.key,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<ConversionController>(
        builder: (context, controller, child) {
          switch(controller.resource.state) {
            case RequestState.ERROR: return _errorScreen(context, controller.resource.message);
            case RequestState.LOADING: return _loadingScreen();
            case RequestState.SUCCESS: return _pageBody(context);
            default: return Container();
          }
        }
      ),
    );
  }

  Widget _loadingScreen() => Center(
    child: Loader(),
  );

  Widget _errorScreen(BuildContext context, String error) => Center(
    child: IconInfo(
        Icons.close,
        Theme.of(context).primaryColorDark,
        Colors.red,
        44,
        "Error: $error"
    ),
  );

  Widget _pageBody(BuildContext context) => Column(
    children: [
      SizedBox(height: height * 0.2, child: _back(context)),
      SizedBox(height: height * 0.3, child: _content(context)),
      SizedBox(height: height * 0.5, child: Keyboard()),
      // _content(context),
      // Keyboard(),
    ],
  );

  Widget _back(BuildContext context) => Container(
    padding: EdgeInsets.only(left: 20),
    width: MediaQuery.of(context).size.width,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: _controller.onPressedGoBack,
          mini: true,
          backgroundColor: Theme.of(context).primaryColorDark,
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        SizedBox(width: 15,),
        Text(
          "Currencies available",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).primaryColorDark
          ),
        ),
      ],
    ),
  );

  Widget _content(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
      ),
    ),
    child: Column(
      children: [
        _currencies(context),
        _resultTable(context),
      ],
    ),
  );

  Widget _currencies(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        children: [
          _conversionTextHelper(context, "From"),
          _dropDownButtonCurrencyFrom(context)
        ],
      ),
      Column(
        children: [
          _conversionTextHelper(context, "To"),
          _dropDownButtonCurrencyTo(context)
        ],
      ),
    ],
  );

  Widget _conversionTextHelper(BuildContext context, String text) => Text(
    "Currency $text",
    style: TextStyle(
      color: Theme.of(context).scaffoldBackgroundColor,
      fontSize: 18,
      fontWeight: FontWeight.w800
    ),
  );

  Widget _dropDownButtonCurrencyFrom(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width * 0.2,
    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
    alignment: Alignment.center,
    child: Consumer<ConversionController>(
      builder: (context, controller, child) {
        return DropdownButton(
          dropdownColor: Colors.white,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).primaryColorDark,
          ),
          iconSize: 25,
          elevation: 10,
          isExpanded: true,
          isDense: false,
          underline: SizedBox(),
          value: controller.currencyFrom,
          onChanged: controller.onChangeCoinFrom,
          items: controller.currencies.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            );
          }).toList(),
        );
      },
    ),
  );

  Widget _dropDownButtonCurrencyTo(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width * 0.2,
    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
    alignment: Alignment.center,
    child: Consumer<ConversionController>(
      builder: (context, controller, child) {
        return DropdownButton(
          dropdownColor: Colors.white,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).primaryColorDark,
          ),
          iconSize: 25,
          elevation: 10,
          isExpanded: true,
          isDense: false,
          underline: SizedBox(),
          value: controller.currencyTo,
          onChanged: controller.onChangeCoinTo,
          items: controller.currencies.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            );
          }).toList(),
        );
      },
    ),
  );



  Widget _resultTable(BuildContext context) {
    final rowHeight = 45.0;
    return Table(
      children: [
        TableRow(
            children: [
              Container(
                alignment: Alignment.center,
                height: rowHeight,
                child: Consumer<ConversionController>(
                  builder: (context, controller, child) => _tableText(context, "From ${controller.currencyFrom}: ")
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: rowHeight,
                child: Consumer<ConversionController>(
                  builder: (context, controller, child) {
                    final text = controller?.valueFrom ?? "";
                    return _tableText(context, text.isEmpty ? "0" : text);
                  },
                ),
              )
            ]
        ),
        TableRow(
            children: [
              Container(
                alignment: Alignment.center,
                height: rowHeight,
                child: Consumer<ConversionController>(
                  builder: (context, controller, child) => _tableText(context, "To ${controller.currencyTo}: ")
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: rowHeight,
                child: Consumer<ConversionController>(
                  builder: (context, controller, child) {
                    final text = controller?.valueTo ?? "";
                    return _tableText(context, text.isEmpty ? "-" : text);
                  },
                ),
              )
            ]
        ),
      ],
    );
  }

  Widget _tableText(BuildContext context, String text) => Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: Theme.of(context).scaffoldBackgroundColor,
      fontSize: 18
    ),
  );
}
