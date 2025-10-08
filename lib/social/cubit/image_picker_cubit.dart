// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/social/cubit/image_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  final maxImages = 10;

  ImagePickerCubit() : super(ImageInitial());

  List<XFile> get images => _images;

  Future<void> pickMultipleImages() async {
    emit(ImageLoading());
    try {
      final List<XFile>? pickedImages = await _picker.pickMultiImage();
      if (pickedImages != null) {
        if (_images.length + pickedImages.length > maxImages) {
          emit(ImageError(message: "Cannot select more than $maxImages images"));
        } else {
          _images.addAll(pickedImages);
          emit(ImageLoaded());
        }
      } else {
        emit(ImageError(message: "No images selected"));
      }
    } catch (e) {
      emit(ImageError(message: "Failed to pick images: $e"));
    }
  }

  Future<void> captureImageWithCamera() async {
    emit(ImageLoading());
    try {
      final XFile? capturedImage = await _picker.pickImage(source: ImageSource.camera);
      if (capturedImage != null) {
        _images.add(capturedImage);
        emit(ImageLoaded());
      } else {
        emit(ImageError(message: "No image captured"));
      }
    } catch (e) {
      emit(ImageError(message: "Failed to capture image: $e"));
    }
  }

  void hasReachedMaxImages() {
    // TODO i18n for error messages
    emit(ImageError(message: "Cannot select more than $maxImages images"));
  }

  void removeImage(int index) {
    _images.removeAt(index);
    emit(ImageLoaded());
  }
}
