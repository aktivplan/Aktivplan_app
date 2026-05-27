import 'dart:io';

import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

extension FileExtention on FileSystemEntity {
  MediaType get contentType {
    return MediaType.parse(lookupMimeType(this.path) ?? "");
  }
}
