// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math';

import 'package:flutter/material.dart';

class StatusCircle extends StatelessWidget {
  final int numberOfStatus;
  final int indexOfSeenStatus;
  final double spacing;
  final double radius;
  final double padding;
  final String? centerImageUrl;
  final double strokeWidth;
  final Color seenColor;
  final Color unSeenColor;

  StatusCircle(
      {this.numberOfStatus = 10,
      this.indexOfSeenStatus = 0,
      this.spacing = 10.0,
      this.radius = 50,
      this.padding = 5,
      this.centerImageUrl,
      this.strokeWidth = 4,
      this.seenColor = Colors.grey,
      this.unSeenColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            child: CustomPaint(
              painter: Arc(
                alreadyWatch: indexOfSeenStatus,
                numberOfArc: numberOfStatus,
                spacing: spacing,
                strokeWidth: strokeWidth,
                seenColor: seenColor,
                unSeenColor: unSeenColor,
              ),
            ),
          ),
          centerImageUrl != null && centerImageUrl!.isNotEmpty
              ? CircleAvatar(
                  radius: radius - padding,
                  backgroundImage: NetworkImage(centerImageUrl!),
                )
              : Container(
                  width: radius * 2,
                  height: radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                    size: 48,
                  ),
                  alignment: Alignment.center,
                )
        ],
      ),
    );
  }
}

class Arc extends CustomPainter {
  final int numberOfArc;
  final int alreadyWatch;
  final double spacing;
  final double strokeWidth;
  final Color seenColor;
  final Color unSeenColor;
  Arc(
      {required this.numberOfArc,
      required this.alreadyWatch,
      required this.spacing,
      required this.strokeWidth,
      required this.seenColor,
      required this.unSeenColor});

  double doubleToAngle(double angle) => angle * pi / 180.0;

  void drawArcWithRadius(Canvas canvas, Offset center, double radius, double angle, Paint seenPaint, Paint unSeenPaint, double start, double spacing,
      int number, int alreadyWatch) {
    for (var i = 0; i < number; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        doubleToAngle((start - ((angle + spacing) * i))),
        doubleToAngle(-angle),
        false,
        i < alreadyWatch ? seenPaint : unSeenPaint,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = size.width / 2.0;
    double angle = numberOfArc == 1 ? 360.0 : (360.0 / numberOfArc - spacing);
    var startingAngle = 270.0;

    Paint seenPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = seenColor;

    Paint unSeenPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = unSeenColor;

    drawArcWithRadius(canvas, center, radius, angle, seenPaint, unSeenPaint, startingAngle, spacing, numberOfArc, alreadyWatch);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
