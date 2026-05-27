import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/social/status_circle.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> with TraceablePageMixin {
  SocialBloc? socialBloc;
  final UserRepository userRepository = KiwiContainer().resolve<UserRepository>();

  @override
  void initState() {
    super.initState();
    socialBloc = BlocProvider.of<SocialBloc>(context);
//  ? inital contacs fetch blocks confirmation message
    if (userRepository.currentUser != null) {
      socialBloc!.add(FetchContactsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      key: Key(KEY_PATIENT_DATA_SCROLL_VIEW),
      child: Center(
        child: ResponsiveBuilder(builder: (context, size) {
          final double containerWidth = size.isMobile ? width : width * 0.5;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: containerWidth,
                child: BlocConsumer<SocialBloc, SocialState>(
                  listenWhen: (previous, state) {
                    return true;
                  },
                  listener: (context, state) {
                    var snackBar;
                    if (state is AddedContactState) {
                      snackBar = getSnackbar(state.success ? context.i18n.addedContact : context.i18n.addedContactError, size.isMobile, context,
                          error: !state.success);
                    } else if (state is RemovedContactState) {
                      snackBar = getSnackbar(state.success ? context.i18n.removedContact : context.i18n.removedContactError, size.isMobile, context,
                          error: !state.success);
                    } else if (state is PostedStoryMessageState || state is PostedStoryImagesState) {
                      var success = (state as PostedStoryMessageState).success || (state as PostedStoryImagesState).success;
                      snackBar = getSnackbar(
                          success ? context.i18n.postedStatusMessage : context.i18n.postedStatusMessageError, size.isMobile, context,
                          error: !success);

                      socialBloc!.add(FetchContactsEvent());
                    }
                    if (snackBar != null) {
                      snackBar.show(context);
                      snackBar = null;
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchedContactOverview || state is ReorderedContactsState) {
                      UserContactOverviewDTO overview =
                          (state is FetchedContactOverview) ? state.overview : (state as ReorderedContactsState).overview;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 20),
                          SelectableText(
                            context.i18n.state,
                            style: getBreadCrumbStyle(context),
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: GestureDetector(
                              onTap: () {
                                overview.statusFilesCount != null && overview.statusFilesCount! > 0
                                    ? context.beamToNamed(
                                        "/contacts/story/${userRepository.currentUser!.id}?fullName=${userRepository.user!.patient!.firstName} ${userRepository.user!.patient!.lastName}&profilePicture=${Uri.encodeComponent(overview.profilePicture?.url ?? '')}")
                                    : null;
                              },
                              child: _buildContactAvatar(overview),
                            ),
                            title: SelectableText("${userRepository.user?.patient?.firstName} ${userRepository.user?.patient?.lastName}",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                            subtitle: (userRepository.user?.patient?.statusMessage ?? "").isNotEmpty
                                ? Text(userRepository.user?.patient?.statusMessage ?? "")
                                : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.text_format),
                                  onPressed: () {
                                    context.beamToNamed('/contacts/my-story/add-message');
                                  },
                                ),
                                if (!kIsWeb)
                                  IconButton(
                                    icon: Icon(Icons.camera_alt_outlined),
                                    onPressed: () {
                                      context.beamToNamed('/contacts/my-story/add-pictures');
                                    },
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            style: getElevatedButtonStyle(context, backgroundColor: extraActivityColor),
                            onPressed: () {
                              context.beamToNamed("/contacts/add");
                            },
                            icon: Icon(Icons.add),
                            label: Text(
                              context.i18n.addContact.toUpperCase(),
                            ),
                          ),
                          if (overview.contacts.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: SelectableText(
                                context.i18n.myContacts,
                                style: getBreadCrumbStyle(context),
                              ),
                            ),
                          ReorderableListView.builder(
                            buildDefaultDragHandles: false,
                            shrinkWrap: true,
                            itemCount: overview.contacts.length,
                            onReorder: (int oldIndex, int newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final orderedIds = overview.contacts.map((entry) => entry.id!).toList();
                                final String item = orderedIds.removeAt(oldIndex);
                                orderedIds.insert(newIndex, item);
                                socialBloc!.add(ResetSocialBlocEvent());
                                socialBloc!.add(ReorderContactsEvent(orderedIds: orderedIds, overview: overview));
                              });
                            },
                            itemBuilder: (context, index) {
                              final hasStatusMessage = (overview.contacts[index].statusMessage ?? "").isNotEmpty;
                              return Padding(
                                key: Key(overview.contacts[index].id!),
                                padding: EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ReorderableDragStartListener(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: Icon(Icons.menu),
                                          ),
                                          index: index),
                                      GestureDetector(
                                        onTap: () {
                                          overview.contacts[index].statusFilesCount != null && overview.contacts[index].statusFilesCount! > 0
                                              ? context.beamToNamed(
                                                  "/contacts/story/${overview.contacts[index].id}?fullName=${overview.contacts[index].fullName}&profilePicture=${Uri.encodeComponent(overview.contacts[index].profilePicture?.url ?? '')}")
                                              : null;
                                        },
                                        child: _buildContactAvatar(overview.contacts[index]),
                                      ),
                                    ],
                                  ),
                                  title: Text(overview.contacts[index].fullName!,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                                  subtitle: hasStatusMessage ? Text(overview.contacts[index].statusMessage!) : null,
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if ((overview.contacts[index].shareActivityData ?? false))
                                        getProgressStateForPatient(overview.contacts[index].activityPercentageCurrentWeek ?? -1),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.chevron_right),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    context.beamToNamed("/contacts/${overview.contacts[index].id}");
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget getProgressStateForPatient(int percentageValue) {
    if (percentageValue < 0) {
      return Container();
    }
    return getTrafficLightForPercentage(
      percentageValue,
      20,
      childWidget: Center(
        child: Text("!", style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }

  Widget _buildContactAvatar(dynamic contact) {
    if (contact?.statusFilesCount != null && contact.statusFilesCount! > 0) {
      return StatusCircle(
        centerImageUrl: contact.storyPictureThumbnail?.exists != null && contact.storyPictureThumbnail!.exists!
            ? contact.storyPictureThumbnail!.url
            : contact.profilePicture!.exists!
                ? contact.profilePicture!.url
                : null,
        radius: 28,
        numberOfStatus: contact.statusFilesCount ?? 0,
        indexOfSeenStatus: contact.seenStatusFilesCount,
      );
    } else if (contact?.profilePicture?.exists ?? false) {
      return CircleAvatar(
        backgroundImage: NetworkImage(contact.profilePicture!.url!),
        radius: 28,
        backgroundColor: Colors.transparent,
      );
    } else {
      return Icon(Icons.account_circle, color: Colors.grey, size: 56);
    }
  }

  String get traceablePageName => "My Contacts Page";
}
