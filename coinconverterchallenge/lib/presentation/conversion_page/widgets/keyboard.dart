import 'package:coinconverterchallenge/presentation/conversion_page/conversion_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keyboard_input.dart';

class Keyboard extends StatelessWidget {

  ConversionController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = _controller == null ? Provider.of<ConversionController>(context) : _controller;
    return Container(
      color: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardInput(
                    _keyboardNumber(context, "1"),
                    () { _controller.onPressedNumber("1"); }
                ),
                KeyboardInput(
                    _keyboardNumber(context, "2"),
                    () { _controller.onPressedNumber("2"); }
                ),
                KeyboardInput(
                    _keyboardNumber(context, "3"),
                    () { _controller.onPressedNumber("3"); }
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardInput(
                    _keyboardNumber(context, "4"),
                    () { _controller.onPressedNumber("4"); }
                ),
                KeyboardInput(
                    _keyboardNumber(context, "5"),
                    () { _controller.onPressedNumber("5"); }
                ),
                KeyboardInput(
                    _keyboardNumber(context, "6"),
                    () { _controller.onPressedNumber("6"); }
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardInput(
                    _keyboardNumber(context, "7"),
                    () { _controller.onPressedNumber("7"); }
                ),
                KeyboardInput(
                    _keyboardNumber(context, "8"),
                    () { _controller.onPressedNumber("8"); }
                ),
                KeyboardInput(
                    _keyboardNumber(context, "9"),
                    () { _controller.onPressedNumber("9"); }
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardInput(
                    _keyboardIcon(context, Icons.arrow_left),
                    _controller.onPressedEraseOneNumber
                ),
                KeyboardInput(
                    _keyboardNumber(context, "0"),
                    () { _controller.onPressedNumber("0"); }
                ),
                KeyboardInput(
                    _keyboardIcon(context, Icons.done),
                    () { _controller.onPressedDone(); }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _keyboardNumber(BuildContext context, String number) => Text(
    number,
    style: TextStyle(
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.w600,
        fontSize: 20
    ),
  );

  Widget _keyboardIcon(BuildContext context, IconData icon) => Icon(
    icon,
    color: Theme.of(context).accentColor,
    size: 30,
  );
}
