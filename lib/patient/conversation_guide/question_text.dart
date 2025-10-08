// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/cupertino.dart';

class QuestionText {
  final String question;
  final String answer;
  final String moreText1;
  final String moreText2;
  bool showAnswer = false;
  bool showMore1 = false;
  bool showMore2 = false;

  QuestionText(this.question, this.answer, [this.moreText1 = "", this.moreText2 = ""]);

  getAnswerText() {
    if (this.showMore1) {
      return moreText1;
    } else if (this.showMore2) {
      return moreText2;
    }
    return answer;
  }

  static List<QuestionText> getQuestionTexts(BuildContext context, int progressLevel, InstitutionFocus institutionFocus) {
    switch (progressLevel) {
      case -1:
        return [
          QuestionText(
              context.i18n.conversationGuideStep0Question1,
              institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION
                  ? context.i18n.conversationGuideStep0Question1Answer
                  : context.i18n.conversationGuideStep0Question1AnswerHealthyLifeStyle),
          QuestionText(context.i18n.conversationGuideStep0Question2, context.i18n.conversationGuideStep0Question2Answer)
        ];
      case 0:
        return [
          if (institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION)
            QuestionText(context.i18n.conversationGuideStep1Question1, context.i18n.conversationGuideStep1Question1Answer),
          if (institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION)
            QuestionText(context.i18n.conversationGuideStep1Question2, context.i18n.conversationGuideStep1Question2Answer),
          if (institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION)
            QuestionText(context.i18n.conversationGuideStep1Question3, context.i18n.conversationGuideStep1Question3Answer),
          QuestionText(
              context.i18n.conversationGuideStep1Question4,
              institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION
                  ? context.i18n.conversationGuideStep1Question4Answer
                  : context.i18n.conversationGuideStep1Question4AnswerHealthyLifeStyle,
              context.i18n.conversationGuideStep1Question4AnswerMore1,
              context.i18n.conversationGuideStep1Question4AnswerMore2),
        ];
      case 1:
        return [
          QuestionText(context.i18n.conversationGuideStep2Question1, context.i18n.conversationGuideStep2Question1Answer),
          QuestionText(context.i18n.conversationGuideStep2Question2, context.i18n.conversationGuideStep2Question2Answer),
          QuestionText(context.i18n.conversationGuideStep2Question3, context.i18n.conversationGuideStep2Question3Answer,
              context.i18n.conversationGuideStep2Question3AnswerMore1, context.i18n.conversationGuideStep2Question3AnswerMore2),
          QuestionText(context.i18n.conversationGuideStep2Question4, context.i18n.conversationGuideStep2Question4Answer,
              context.i18n.conversationGuideStep1Question4AnswerMore1, context.i18n.conversationGuideStep1Question4AnswerMore2),
        ];
      case 2:
        return [
          QuestionText(context.i18n.conversationGuideStep3Question1, context.i18n.conversationGuideStep3Question1Answer,
              context.i18n.conversationGuideStep3Question1AnswerMore1),
          QuestionText(context.i18n.conversationGuideStep3Question2, context.i18n.conversationGuideStep3Question2Answer,
              context.i18n.conversationGuideStep3Question2AnswerMore1, context.i18n.conversationGuideStep3Question2AnswerMore2),
        ];
      default:
        return [];
    }
  }
}
