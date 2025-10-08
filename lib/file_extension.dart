// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:io';

import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

extension FileExtention on FileSystemEntity {
  MediaType get contentType {
    return MediaType.parse(lookupMimeType(this.path) ?? "");
  }
}
