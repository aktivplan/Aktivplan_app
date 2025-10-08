// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'social_bloc.dart';

abstract class SocialEvent extends Equatable {
  const SocialEvent();

  @override
  List<Object> get props => [];
}

class FetchContactsEvent extends SocialEvent {
  FetchContactsEvent();

  @override
  List<Object> get props => [];
}

class FetchContactDetailEvent extends SocialEvent {
  final String userId;
  final String startDate;
  final String endDate;
  FetchContactDetailEvent({required this.userId, required this.startDate, required this.endDate});

  @override
  List<Object> get props => [userId];
}

class FetchStoryEvent extends SocialEvent {
  final String userId;

  FetchStoryEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddContactEvent extends SocialEvent {
  final String userId;
  AddContactEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class RemoveContactEvent extends SocialEvent {
  final String userId;
  RemoveContactEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ReorderContactsEvent extends SocialEvent {
  final List<String> orderedIds;
  final UserContactOverviewDTO overview;

  ReorderContactsEvent({required this.orderedIds, required this.overview});

  @override
  List<Object> get props => [orderedIds, overview];
}

class SendSocialMessageEvent extends SocialEvent {
  final SocialMessagePostDTO message;
  final MultipartFile? picture;

  SendSocialMessageEvent({required this.message, this.picture});

  @override
  List<Object> get props => [message];
}

class PostStoryMessageEvent extends SocialEvent {
  final String message;

  PostStoryMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class PostStoryImagesEvent extends SocialEvent {
  final List<MultipartFile> images;

  PostStoryImagesEvent({required this.images});

  @override
  List<Object> get props => [images];
}

class RemoveStoryItemEvent extends SocialEvent {
  final String fileId;

  RemoveStoryItemEvent({required this.fileId});

  @override
  List<Object> get props => [fileId];
}

class MarkStoryItemAsSeenEvent extends SocialEvent {
  final String fileId;

  MarkStoryItemAsSeenEvent({required this.fileId});

  @override
  List<Object> get props => [];
}

class ResetSocialBlocEvent extends SocialEvent {
  ResetSocialBlocEvent();

  @override
  List<Object> get props => [];
}
