import 'dart:math';

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_text/styled_text.dart';

class OnboardingPage extends StatefulWidget {
  final bool isKlimafit;
  final bool isSinglePage;
  const OnboardingPage({Key? key, required this.isKlimafit, this.isSinglePage = false}) : super(key: key);

  static Future<void> showOnboardingDialog(BuildContext context, {required bool isKlimafit}) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OnboardingPage(isKlimafit: isKlimafit),
    ));
  }

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TraceablePageMixin {
  int currentStep = 1;

  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double containerWidth = min(450, width);
    double imageSize = containerWidth;
    if (height < 500) {
      imageSize = containerWidth * 0.4;
    } else if (height < 600) {
      imageSize = containerWidth * 0.5;
    } else if (height < 650) {
      imageSize = containerWidth * 0.7;
    } else if (height < 750) {
      imageSize = containerWidth * 0.8;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                color: currentStep > 1 ? mobileBackgroundColor : Colors.transparent,
                width: double.infinity,
                height: imageSize,
                child: Image.asset(
                  "assets/images/onboarding-$currentStep.png",
                  width: imageSize,
                ),
              ),
              Container(
                width: containerWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        height: max(230, height * 0.15),
                        child: StyledText(
                          text: getDescriptionText(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                          tags: {
                            'h1': StyledTextTag(style: TextStyle(fontSize: 28)),
                            'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          key: Key(KEY_ONBOARDING_BUTTON_NEXT),
                          onPressed: () {
                            setState(() {
                              if (currentStep < 7) {
                                currentStep++;
                              } else if (widget.isSinglePage) {
                                currentStep = 1;
                              } else {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                          style: getElevatedButtonStyle(context),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text((currentStep == 1
                                    ? context.i18n.startTour
                                    : currentStep == 7
                                        ? widget.isSinglePage
                                            ? context.i18n.startTourAgain
                                            : context.i18n.letsGo
                                        : context.i18n.next)
                                .toUpperCase()),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      if (!widget.isSinglePage)
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: TextButton(
                            key: Key(KEY_ONBOARDING_BUTTON_BACK),
                            child: Text(currentStep == 1 ? context.i18n.skip : context.i18n.back),
                            onPressed: () {
                              setState(() {
                                if (currentStep > 1) {
                                  currentStep--;
                                } else {
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                          ),
                        ),
                      SizedBox(height: height * 0.02),
                      getProgessDots(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getDescriptionText() {
    switch (currentStep) {
      case 1:
        return context.i18n.onboardingText1;
      case 2:
        return context.i18n.onboardingText2;
      case 3:
        return widget.isKlimafit ? context.i18n.onboardingText3Klimafit : context.i18n.onboardingText3;
      case 4:
        return context.i18n.onboardingText4;
      case 5:
        return context.i18n.onboardingText5;
      case 6:
        return context.i18n.onboardingText6;
      case 7:
      default:
        return context.i18n.onboardingText7;
    }
  }

  getProgessDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 2; i <= 7; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: i == currentStep ? primaryColor : mobileBackgroundColor,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
      ],
    );
  }

  String get traceablePageName => "Onboarding Page";
}
