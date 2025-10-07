import 'package:apt_api/api.dart';
import 'package:aptapp/social/social_controller_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';

part 'social_event.dart';
part 'social_state.dart';

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  SocialBloc() : super(SocialInitial()) {
    final SocialControllerRepository socialControllerRepository = KiwiContainer().resolve<SocialControllerRepository>();
    on<ResetSocialBlocEvent>((event, emit) async {
      emit(SocialInitial());
    });
    on<AddContactEvent>((event, emit) async {
      final bool success = await socialControllerRepository.addContact(userId: event.userId) ?? false;
      emit(AddedContactState(success: success));
      add(FetchContactsEvent());
    });
    on<RemoveContactEvent>((event, emit) async {
      final bool success = await socialControllerRepository.removeContact(userId: event.userId) ?? false;
      emit(RemovedContactState(success: success));
      add(FetchContactsEvent());
    });
    on<ReorderContactsEvent>((event, emit) async {
      final List<String> orderedIds = event.orderedIds;
      socialControllerRepository.updateContactOrdering(orderedIds);
      final List<UserContactDTO> orderedContacts = [];
      for (String id in orderedIds) {
        UserContactDTO contact = event.overview.contacts.firstWhere((element) => element.id == id);
        orderedContacts.add(contact);
      }
      event.overview.contacts = orderedContacts;
      emit(ReorderedContactsState(overview: event.overview));
    });
    on<FetchContactsEvent>((event, emit) async {
      UserContactOverviewDTO? overview = await socialControllerRepository.getContactOverview();
      emit(FetchedContactOverview(overview: overview!));
    });
    on<FetchContactDetailEvent>((event, emit) async {
      UserContactDetailDTO? detail =
          await socialControllerRepository.getContactDetail(userId: event.userId, startDate: event.startDate, endDate: event.endDate);
      emit(FetchedContactDetail(detail: detail!));
    });
    on<SendSocialMessageEvent>((event, emit) async {
      await socialControllerRepository.sendSocialMessage(message: event.message, picture: event.picture);
      emit(SentSocialMessageState(success: true));
    });
    on<PostStoryMessageEvent>((event, emit) async {
      try {
        var res = await socialControllerRepository.uploadStatusText(message: StatusTextPostDTO(statusText: event.message));
        bool success = res != null;
        emit(PostedStoryMessageState(success: success));
      } on Exception {
        emit(PostedStoryMessageState(success: false));
      }
    });
    on<PostStoryImagesEvent>((event, emit) async {
      try {
        bool success = await socialControllerRepository.uploadStatusPictures(files: event.images) ?? false;
        emit(PostedStoryImagesState(success: success));
      } on Exception {
        emit(PostedStoryImagesState(success: false));
      }
    });
    on<FetchStoryEvent>((event, emit) async {
      List<StatusFileDTO>? statusFiles = await socialControllerRepository.getStatusFiles(userId: event.userId);
      emit(FetchedStoryState(statusFiles: statusFiles ?? []));
    });
    on<RemoveStoryItemEvent>((event, emit) async {
      final result = await socialControllerRepository.deleteStatusFile(id: event.fileId);
      final bool success = result ?? false;
      emit(RemovedStoryItemState(success: success));
    });
    on<MarkStoryItemAsSeenEvent>((event, emit) async {
      try {
        await socialControllerRepository.markStoryItemAsSeen(id: event.fileId);
      } catch (e) {
        print("error on marking story item as seen: $e");
      }
      ;
    });
  }
}
