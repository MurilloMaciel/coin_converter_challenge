import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: shape,
        title: Text(
          "About"
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30,),
        CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage(
              "assets/murillo.png"
          ),
        ),
        SizedBox(height: 30,),
        Text(
          "Murillo M. Maciel",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 18,
            fontWeight: FontWeight.w800
          ),
        ),
        SizedBox(height: 3,),
        Text(
          "Mobile Developer",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 12,
              fontWeight: FontWeight.w300
          ),
        ),
        SizedBox(height: 30,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text(
            "I appreciate ....",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
            ),
          ),
        )
      ],
    ),
  );
}
