import 'package:flutter/material.dart';

class KeyboardInput extends StatelessWidget {

  final Widget content;
  final Function() onPressed;

  KeyboardInput(this.content, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        radius: 25,
        child: content,
      ),
    );
  }
}
