import 'package:coinconverterchallenge/presentation/coins_page/coins_controller.dart';
import 'package:coinconverterchallenge/presentation/model/coins_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

  CoinsFilter filter;

  CoinsController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = _controller == null ? Provider.of<CoinsController>(context) : _controller;
    filter = filter == null ? _controller.filter : filter;
    return Dialog(
      elevation: 50,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Order by',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                  ),
                  _content(context),
                ],
              ),
            ),
            _button(context),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) => Expanded(
      child:  Consumer<CoinsController>(
        builder: (context, controller, child) {
          return Column(
            children: [
              _radioButton(context, CoinsFilter.CURRENCY, "Coin code"),
              _radioButton(context, CoinsFilter.NAME, "Coin name"),
            ],
          );
        }
      )
  );

  Widget _radioButton(BuildContext context, CoinsFilter value, String label) => Row(
    children: [
      Radio(
        activeColor:Theme.of(context).primaryColorDark,
        value: value,
        groupValue: filter,
        onChanged: _setFilter,
      ),
      Text(
        label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ],
  );

  Widget _button(BuildContext context) => Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    child: CircleAvatar(
      radius: 40,
      backgroundColor: Theme.of(context).primaryColorDark,
      child: RawMaterialButton(
        shape: CircleBorder(),
        elevation: 20.0,
        child: Icon(
          Icons.check,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          _controller.setFilterType(filter);
          Navigator.of(context).pop();
        },
      ),
    ),
  );

  void _setFilter(CoinsFilter filter) {
    setState(() {
      this.filter = filter;
    });
  }
}