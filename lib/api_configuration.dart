// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

// Openapi Generator last run: : 2025-04-11T07:27:58.008449
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'apt_api', pubAuthor: 'Alphaport'),
    inputSpec: RemoteSpec(path: 'https://aktivplan-plus.ap-stage.at/v3/api-docs.json'),
    generatorName: Generator.dart,
    skipIfSpecIsUnchanged: false,
    outputDirectory: 'api/apt_api')
class ApiConfiguration {}