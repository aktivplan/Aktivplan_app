// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:io';

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/social/cubit/image_cubit_state.dart';
import 'package:aptapp/social/cubit/image_picker_cubit.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as img;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:share_plus/share_plus.dart';

class AddStoryPicturesPage extends StatefulWidget {
  AddStoryPicturesPage({
    Key? key,
  }) : super(key: key);

  @override
  _AddStoryPicturesPageState createState() => _AddStoryPicturesPageState();
}

class _AddStoryPicturesPageState extends State<AddStoryPicturesPage> with TraceablePageMixin, WidgetsBindingObserver {
  SocialBloc? socialBloc;
  final imageController = TextEditingController();
  bool _isLoading = false;

  MultipartFile? statusImages;
  Uint8List? uploadedPicture;

  @override
  void initState() {
    super.initState();
    socialBloc = BlocProvider.of<SocialBloc>(context);
  }

  @override
  void dispose() {
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ResponsiveBuilder(
        builder: (context, size) {
          final double containerWidth = size.isMobile ? width : width * 0.5;
          return BlocProvider(
            create: (_) => ImagePickerCubit(),
            child: BlocListener<SocialBloc, SocialState>(
              listener: (context, state) {
                // ? message not posted here
                if (state is PostedStoryImagesState) {
                  var snackBar;

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
              child: Container(
                padding: EdgeInsets.only(top: 15),
                width: containerWidth,
                height: double.infinity,
                color: Theme.of(context).secondaryHeaderColor,
                child: BlocConsumer<ImagePickerCubit, ImagePickerState>(
                  listener: (context, state) {
                    var snackBar;

                    if (state is ImageError) {
                      snackBar = getSnackbar(state.message, size.isMobile, context, error: true);
                    }
                    if (snackBar != null) {
                      snackBar.show(context);
                      snackBar = null;
                    }
                  },
                  builder: (context, state) {
                    final images = context.watch<ImagePickerCubit>().images;

                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: images.isNotEmpty
                                  ? GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemCount: images.length,
                                      itemBuilder: (context, index) {
                                        final image = images[index];
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.file(File(image.path), fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              top: 7,
                                              right: 4,
                                              child: GestureDetector(
                                                onTap: _isLoading ? null : () => context.read<ImagePickerCubit>().removeImage(index),
                                                child: CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor: errorColor,
                                                  child: Icon(Icons.close, size: 16, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : Text(
                                      context.i18n.noImagesSelected,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 260,
                              width: 340,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: primaryColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo, size: 50, color: primaryColor),
                                    SizedBox(height: 5),
                                    Text(
                                      context.i18n.postImageTitle,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      context.i18n.postImageText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          if (images.length >= 10) {
                                            context.read<ImagePickerCubit>().hasReachedMaxImages();
                                            return;
                                          }
                                          if (!_isLoading) {
                                            context.read<ImagePickerCubit>().pickMultipleImages();
                                          }
                                        },
                                        icon: Icon(Icons.photo_library, color: Colors.white),
                                        label: Text(
                                          context.i18n.browseGallery,
                                          style: TextStyle(fontSize: 14, color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          if (images.length >= 10) {
                                            context.read<ImagePickerCubit>().hasReachedMaxImages();
                                            return;
                                          }
                                          if (!_isLoading) {
                                            context.read<ImagePickerCubit>().captureImageWithCamera();
                                          }
                                        },
                                        icon: Icon(Icons.camera_alt, color: Colors.white),
                                        label: Text(
                                          context.i18n.captureImageWithCamera,
                                          style: TextStyle(fontSize: 14, color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: width,
                              child: ElevatedButton.icon(
                                style: getElevatedButtonStyle(context, backgroundColor: primaryColor),
                                onPressed: images.length == 0 || _isLoading
                                    ? null
                                    : () {
                                        _uploadStoryImages(images);
                                      },
                                icon: _isLoading ? CircularProgressIndicator(color: Colors.white) : Icon(Icons.send),
                                label: _isLoading
                                    ? Text('')
                                    : Text(
                                        context.i18n.postStatus.toUpperCase(),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<File> _correctImageOrientation(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final img.Image? originalImage = img.decodeImage(bytes);

    if (originalImage == null) {
      return imageFile;
    }

    img.Image orientedImage = img.bakeOrientation(originalImage);
    if ((orientedImage.data?.height ?? 0) > 1000) {
      orientedImage = img.copyResize(orientedImage, height: 1000);
    }
    final correctedBytes = img.encodeJpg(orientedImage, quality: 80);

    final correctedFile = File(imageFile.path);
    await correctedFile.writeAsBytes(correctedBytes);

    return correctedFile;
  }

  Future<List<MultipartFile>> getMultiPartFiles(List<XFile> images) async {
    return await Future.wait(images.map((e) async {
      final File file = File(e.path);
      final File correctedFile = await _correctImageOrientation(file);
      var bytes = await correctedFile.readAsBytes();
      return MultipartFile.fromBytes('pictureFile', bytes, filename: correctedFile.path.split('/').last);
    }).toList());
  }

  void _uploadStoryImages(List<XFile> images) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final List<MultipartFile> storyImages = await getMultiPartFiles(images);
      socialBloc!.add(PostStoryImagesEvent(images: storyImages));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String get traceablePageName => "Add Status Text Page";
}
