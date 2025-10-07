import 'package:aptapp/colors.dart';
import 'package:flutter/material.dart';

class CardIconButton extends StatelessWidget {
  final IconData iconData;
  final Function()? callback;

  CardIconButton({
    Key? key,
    required this.iconData,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 12,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: CircleBorder(), elevation: 12, backgroundColor: datatableBorderColor),
        onPressed: callback,
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: goalColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Icon(iconData),
          ),
        ),
      ),
    );
  }
}
