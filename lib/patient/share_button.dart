// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final ScreenshotController screenshotController;
  final String shareContext;
  final Widget? widgetToShare;

  const ShareButton({required this.screenshotController, required this.shareContext, this.widgetToShare});

  share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    final image = this.widgetToShare != null
        ? await screenshotController.captureFromWidget(widgetToShare!)
        : await screenshotController.capture(delay: Duration(microseconds: 100));
    final list = image!.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes);
    Share.shareXFiles([
      XFile.fromData(
        list,
        name: 'aktivplan.png',
        mimeType: 'image/png',
      )
    ], sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: EVENT_SHARE, name: shareContext, action: "Pressed Share Button"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.share, color: primaryColor),
                SizedBox(width: 10),
                Text(
                  context.i18n.share.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      onPressed: () => share(context),
    );
  }
}
