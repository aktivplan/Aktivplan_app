import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HealthProfessionalProfilePage extends StatefulWidget {
  final String userId;
  const HealthProfessionalProfilePage({Key? key, required this.userId}) : super(key: key);
  @override
  _HealthProfessionalProfilePageState createState() => _HealthProfessionalProfilePageState();
}

class _HealthProfessionalProfilePageState extends State<HealthProfessionalProfilePage> with TraceablePageMixin {
  HealthcareProfessionalProfileDTO? profile;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context)..add(FetchHealthcareProfessionalProfileEvent(healthcareProfessionalId: widget.userId));
  }

  Widget renderActivity(ActivityProfileDTO activity) {
    return ListTile(
      minLeadingWidth: 10,
      contentPadding: EdgeInsets.zero,
      leading: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Icon(
          Icons.circle,
          size: 10,
          color: accentColor,
        ),
      ),
      title: SelectableText("${activity.name}, ${activity.type!.getTranslatedText(context)}"),
      subtitle: SelectableText(activity.repeats!.getTranslatedText(context) +
          (activity.days.length > 0 ? ": ${activity.days.map((e) => (e.getTranslatedText(context))).join(', ')}" : "")),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is FetchedHealthcareProfessionalProfileState) {
          profile = state.profile;
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: () {
                context.beamBack();
              },
            ),
          ),
          body: ResponsiveBuilder(builder: (context, size) {
            final double containerWidth = size.isMobile ? width * 0.8 : width * 0.5;

            return Center(
              heightFactor: 1.1,
              child: SingleChildScrollView(
                child: Container(
                  padding: size.isMobile ? EdgeInsets.only(top: 30) : EdgeInsets.only(top: height * 0.1),
                  width: containerWidth,
                  child: profile == null
                      ? Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(children: [
                            if (profile!.userPicture!.exists ?? false)
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(profile!.userPicture!.url!),
                                ),
                              ),
                            ListTile(
                              title: Center(child: SelectableText(profile!.name!)),
                              subtitle: Center(
                                child: SelectableText(profile!.jobName ?? ""),
                              ),
                            ),
                            if (profile!.activities.length > 0)
                              Container(
                                width: containerWidth,
                                padding: EdgeInsets.only(bottom: 5),
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: accentColor))),
                                child: Center(
                                  child: SelectableText(context.i18n.plannedActivities, style: Theme.of(context).textTheme.titleMedium),
                                ),
                              ),
                            for (var activity in profile!.activities) renderActivity(activity)
                          ]),
                        ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  String get traceablePageName => "Health Professional Profile Page";
}
