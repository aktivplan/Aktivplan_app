import 'dart:math';

import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/logout_aware.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/password_form_field.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResetPasswordPage extends StatefulWidget {
  final String resetKey;
  final String languageCode;
  const ResetPasswordPage({Key? key, required this.resetKey, this.languageCode = ""}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with TraceablePageMixin, LogoutAware {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool doReset = false;
  String resetKey = "";
  String resetText = "";
  bool loadingTokenData = true;
  ConsentDataDTO? consentData;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  List<ConsentType> acceptedConsentTypes = [];
  bool updatedPassword = false;

  @override
  void initState() {
    super.initState();
    resetKey = widget.resetKey;
    if (resetKey.isNotEmpty) {
      loadingTokenData = true;
      new ConsentControllerApi(apiClient).getConsents(resetKey).then((value) => {
            setState(() {
              consentData = value;
              loadingTokenData = false;
              acceptedConsentTypes = value!.consents.where((element) => element.accepted).map((e) => e.type).toList();
            })
          });
    }

    if (userRepository.currentUser != null) {
      logout(navigateToHome: false);
    }

    if (widget.languageCode.isNotEmpty) {
      BlocProvider.of<LanguageCubit>(context).setLanguageCode(widget.languageCode);
    }
  }

  resetPassword() {
    if (formKey.currentState!.validate()) {
      final ForgotPasswordDTO forgotPasswordDTO = new ForgotPasswordDTO();
      forgotPasswordDTO.email = emailController.text.trim();
      BlocProvider.of<AuthenticationBloc>(context).add(ForgotPasswordEvent(passwordDTO: forgotPasswordDTO));
      emailController.text = "";
      setState(
        () {
          doReset = true;
          resetText = context.i18n.resetPasswordFeedbackText(forgotPasswordDTO.email!);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = min(500, width * 0.9);
    final String languageCode = Localizations.localeOf(context).languageCode.toLowerCase();

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: containerWidth,
          child: Column(
            children: [
              SizedBox(height: 30),
              Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),
              if (resetKey.isEmpty) SizedBox(height: 20),
              if (resetKey.isEmpty)
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: Key(KEY_RESET_PASSWORD_TEXT_EMAIL),
                        autofillHints: [AutofillHints.email],
                        controller: emailController,
                        validator: (value) {
                          if ((value ?? "").isEmpty || !EmailValidator.validate((value ?? "").trim())) {
                            return context.i18n.validationEmail;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.email,
                          labelText: context.i18n.email,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SelectableText(
                          context.i18n.resetPasswordText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          key: Key(KEY_RESET_PASSWORD_BUTTON_SUBMIT),
                          onPressed: resetPassword,
                          style: getElevatedButtonStyle(context),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(context.i18n.sendLink.toUpperCase()),
                          ),
                        ),
                      ),
                      if (doReset)
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            key: Key(KEY_RESET_PASSWORD_CONFIRMATION),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  SelectableText(
                                    resetText,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              if (resetKey.isNotEmpty && loadingTokenData) Center(child: CircularProgressIndicator()),
              if (resetKey.isNotEmpty && !loadingTokenData && !updatedPassword)
                Form(
                  key: formKey,
                  child: Column(
                    children: getSetPasswordForm(),
                  ),
                ),
              if (updatedPassword)
                StyledText(
                    text: consentData!.userEnabled ?? false ? context.i18n.resetPasswordSet : context.i18n.resetPasswordActivated,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                    tags: {
                      'b': StyledTextTag(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    }),
              if (updatedPassword)
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        md: 6,
                        child: Padding(
                          padding: EdgeInsets.only(right: 0, bottom: 20),
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () => launchUrlString(iosStoreUrl, mode: LaunchMode.externalApplication),
                            child: Image.asset(
                              "assets/images/app_store_$languageCode.png",
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        md: 6,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () => launchUrlString(googlePlayStoreUrl, mode: LaunchMode.externalApplication),
                            child: Image.asset(
                              "assets/images/google_play_$languageCode.png",
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (updatedPassword)
                StyledText(
                    text: context.i18n.resetPasswordLinkToWebpage,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                    tags: {
                      'a': StyledTextActionTag(
                        (text, attrs) {
                          context.beamToNamed('/login');
                        },
                        style: TextStyle(decoration: TextDecoration.underline, color: primaryColor),
                      ),
                      'b': StyledTextTag(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    }),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getSetPasswordForm() {
    if (this.consentData!.errorCause != ConsentErrorCause.NONE) {
      return [
        StyledText(
            text: this.consentData!.errorCause == ConsentErrorCause.RESET_TOKEN_NOT_FOUND
                ? context.i18n.resetPasswordTokenInvalid
                : context.i18n.resetPasswordTokenExpired,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
            tags: {
              'mail': StyledTextActionTag(
                (text, attrs) {
                  String mail = attrs['target']!;
                  launchUrl(
                    Uri(
                      scheme: 'mailto',
                      path: mail,
                    ),
                  );
                },
                style: TextStyle(decoration: TextDecoration.underline, color: primaryColor),
              ),
              'a': StyledTextActionTag(
                (text, attrs) {
                  if (this.consentData!.errorCause == ConsentErrorCause.RESET_TOKEN_NOT_FOUND) {
                    setState(() {
                      resetKey = "";
                    });
                  } else {
                    context.beamToNamed('/login');
                  }
                },
                style: TextStyle(decoration: TextDecoration.underline, color: primaryColor),
              )
            }),
      ];
    }

    List<Widget> consentBoxes = [];
    if (!this.consentData!.userEnabled!) {
      consentBoxes = [
        SizedBox(height: 20),
        ...this.consentData!.consents.map(
          (consent) {
            final urlText = getTranslatedText(consent.url, context);
            String text = getTranslatedText(consent.text, context);
            if (consent.type == ConsentType.TERMS_AND_CONDITIONS) {
              text = context.i18n.consentText_TERMS_AND_CONDITIONS;
            } else if (consent.type == ConsentType.PRIVACY_POLICY) {
              text = context.i18n.consentText_PRIVACY_POLICY;
            }
            return FormField<bool>(
              builder: (state) => ListTileTheme(
                contentPadding: EdgeInsets.zero,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.black,
                  value: acceptedConsentTypes.contains(consent.type),
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        acceptedConsentTypes.add(consent.type);
                      } else {
                        acceptedConsentTypes.remove(consent.type);
                      }
                    });
                    state.didChange(value);
                  },
                  title: StyledText(
                    text: text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                    tags: {
                      'a': StyledTextActionTag(
                        (text, attrs) {
                          if (urlText.isNotEmpty) {
                            launchUrl(
                              Uri.parse(urlText),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        style: urlText.isNotEmpty ? TextStyle(decoration: TextDecoration.underline, color: primaryColor) : null,
                      ),
                    },
                  ),
                  subtitle: state.hasError
                      ? Text(
                          state.errorText!,
                          style: TextStyle(color: errorColor),
                        )
                      : null,
                ),
              ),
              validator: (value) {
                if (!acceptedConsentTypes.contains(consent.type) && consent.required_) {
                  return context.i18n.pleaseAcceptTerms;
                }
                return null;
              },
            );
          },
        ).toList()
      ];
    }

    void doSetPassword() {
      if (!formKey.currentState!.validate()) {
        return;
      }
      final ResetPasswordDTO resetPasswordDTO = new ResetPasswordDTO();
      resetPasswordDTO.password = passwordController.text;
      resetPasswordDTO.resetKey = widget.resetKey;
      resetPasswordDTO.acceptedConsents = new Map();
      acceptedConsentTypes.forEach((element) {
        resetPasswordDTO.acceptedConsents[element.toString()] = consentData!.consents.firstWhere((consent) => consent.type == element).version;
      });
      BlocProvider.of<AuthenticationBloc>(context).add(ResetPasswordEvent(passwordDTO: resetPasswordDTO));
      setState(() {
        updatedPassword = true;
      });
    }

    return [
      StyledText(
        text: consentData!.userEnabled! ? context.i18n.resetPasswordEnterPassword : context.i18n.resetPasswordWelcome(this.consentData!.userName!),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
        tags: {
          'b': StyledTextTag(
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        },
      ),
      SizedBox(height: 20),
      PasswordFormField(
        controller: passwordController,
        labelText: context.i18n.password,
        additionalValidations: (value) {
          if (value != confirmPasswordController.text) {
            return context.i18n.validationPasswordsNotEqual;
          }
          return null;
        },
      ),
      SizedBox(height: 20),
      PasswordFormField(
        controller: confirmPasswordController,
        labelText: context.i18n.confirmPassword,
        additionalValidations: (value) {
          if (value != passwordController.text) {
            return context.i18n.validationPasswordsNotEqual;
          }
          return null;
        },
      ),
      ...consentBoxes,
      SizedBox(height: 20),
      Align(
        alignment: Alignment.centerLeft,
        child: SaveButton(
            title: (consentData!.userEnabled! ? context.i18n.save : context.i18n.resetPasswordRegister).toUpperCase(), callback: doSetPassword),
      ),
      SizedBox(height: 20),
    ];
  }

  String get traceablePageName => "Reset Password Page";
}
