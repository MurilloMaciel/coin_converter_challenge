import 'package:flutter/material.dart';

class IconInfo extends StatelessWidget {

  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final double iconSize;
  final String info;

  IconInfo(this.icon, this.iconBackgroundColor, this.iconColor, this.iconSize, this.info);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: iconBackgroundColor,
          radius: 50,
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
        SizedBox(height: 16,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            info,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
  }
}
