// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'social_bloc.dart';

abstract class SocialState extends Equatable {
  const SocialState();

  @override
  List<Object> get props => [];
}

class SocialInitial extends SocialState {}

class FetchedContactOverview extends SocialState {
  final UserContactOverviewDTO overview;

  FetchedContactOverview({required this.overview});

  @override
  List<Object> get props => [overview];
}

class FetchedContactDetail extends SocialState {
  final UserContactDetailDTO detail;

  FetchedContactDetail({required this.detail});

  @override
  List<Object> get props => [detail];
}

class FetchedStoryState extends SocialState {
  final List<StatusFileDTO> statusFiles;

  FetchedStoryState({required this.statusFiles});

  @override
  List<Object> get props => [statusFiles];
}

class AddedContactState extends SocialState {
  final bool success;
  AddedContactState({required this.success});

  @override
  List<Object> get props => [success];
}

class SentSocialMessageState extends SocialState {
  final bool success;
  SentSocialMessageState({required this.success});

  @override
  List<Object> get props => [success];
}

class PostedStoryMessageState extends SocialState {
  final bool success;
  PostedStoryMessageState({required this.success});

  @override
  List<Object> get props => [success];
}

class PostedStoryImagesState extends SocialState {
  final bool success;
  PostedStoryImagesState({required this.success});

  @override
  List<Object> get props => [success];
}

class ReorderedContactsState extends SocialState {
  final UserContactOverviewDTO overview;

  ReorderedContactsState({required this.overview});

  @override
  List<Object> get props => [overview];
}

class RemovedContactState extends SocialState {
  final bool success;
  RemovedContactState({required this.success});

  @override
  List<Object> get props => [success];
}

class RemovedStoryItemState extends SocialState {
  final bool success;
  RemovedStoryItemState({required this.success});

  @override
  List<Object> get props => [success];
}
