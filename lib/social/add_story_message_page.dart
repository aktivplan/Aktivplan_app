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
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddStoryMessagePage extends StatefulWidget {
  AddStoryMessagePage({Key? key}) : super(key: key);

  @override
  _AddStoryMessagePageState createState() => _AddStoryMessagePageState();
}

class _AddStoryMessagePageState extends State<AddStoryMessagePage> with TraceablePageMixin, WidgetsBindingObserver {
  SocialBloc? socialBloc;
  final _changeFormKey = GlobalKey<FormState>();
  bool _hasError = false;
  bool _isLoading = false;
  final statusMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    socialBloc = BlocProvider.of<SocialBloc>(context);
  }

  @override
  void dispose() {
    statusMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: ResponsiveBuilder(builder: (context, size) {
        final double containerWidth = size.isMobile ? width : width * 0.5;
        return Container(
            padding: EdgeInsets.only(top: 15),
            width: containerWidth,
            child: BlocConsumer<SocialBloc, SocialState>(
              listener: (context, state) {
                var snackBar;
                if (state is PostedStoryMessageState) {
                  snackBar = getSnackbar(
                      state.success ? context.i18n.postedStatusMessage : context.i18n.postedStatusMessageError, size.isMobile, context,
                      error: !state.success);
                  if (snackBar != null) {
                    snackBar.show(context).then((value) {
                      if (state.success) {
                        context.beamBack();
                      }
                      _isLoading = false;
                    });
                    snackBar = null;
                  }
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _changeFormKey,
                        child: Container(
                          color: Colors.white,
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: statusMessageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            readOnly: _isLoading,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: context.i18n.postStatusTextHint,
                              hintMaxLines: 1,
                              labelText: context.i18n.postStatusTextHint + " *",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                              errorText: _hasError ? context.i18n.validationNotEmpty : null,
                            ),
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return context.i18n.validationNotEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton.icon(
                        style: getElevatedButtonStyle(context, backgroundColor: primaryColor),
                        onPressed: _isLoading ? null : () => postStatusText(statusMessageController),
                        icon: _isLoading ? CircularProgressIndicator(color: Colors.white) : Icon(Icons.send),
                        label: _isLoading
                            ? Text('')
                            : Text(
                                context.i18n.postStatus.toUpperCase(),
                              ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ElevatedButton.icon(
                        style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                        onPressed: _isLoading ? null : () => context.beamBack(),
                        label: Text(
                          context.i18n.cancel.toUpperCase(),
                        ),
                      ),
                    )
                  ],
                );
              },
            ));
      }),
    );
  }

  postStatusText(final TextEditingController statusMessageController) {
    if (_changeFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      socialBloc!.add(PostStoryMessageEvent(message: statusMessageController.text));
    } else {
      _hasError = true;
    }
  }

  String get traceablePageName => "Add Status Text Page";
}
