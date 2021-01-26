import 'package:flutter/material.dart';

class Loader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColorDark,
          ),
        ),
        SizedBox(height: 16,),
        Text(
          "Carregando...",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).textSelectionColor,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
