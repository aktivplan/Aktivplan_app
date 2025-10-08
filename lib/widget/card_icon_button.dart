// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
