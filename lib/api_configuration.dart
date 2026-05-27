// Openapi Generator last run: : 2026-05-20T10:43:15.099419
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'apt_api', pubAuthor: 'Alphaport'),
//    inputSpec: RemoteSpec(path: 'https://aktivplan-plus.ap-stage.at/v3/api-docs.json'),
    inputSpec: RemoteSpec(path: 'http://localhost:8080/v3/api-docs.json'),
    generatorName: Generator.dart,
    skipIfSpecIsUnchanged: false,
    outputDirectory: 'api/apt_api')
class ApiConfiguration {}