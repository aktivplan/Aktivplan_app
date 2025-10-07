// Openapi Generator last run: : 2025-04-11T07:27:58.008449
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'apt_api', pubAuthor: 'Alphaport'),
    inputSpec: RemoteSpec(path: 'https://aktivplan-plus.ap-stage.at/v3/api-docs.json'),
    generatorName: Generator.dart,
    skipIfSpecIsUnchanged: false,
    outputDirectory: 'api/apt_api')
class ApiConfiguration {}