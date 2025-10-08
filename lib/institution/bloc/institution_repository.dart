// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';

class InstitutionRepository {
  final institutionApi = new InstitutionControllerApi(apiClient);

  Future<List<InstitutionDTO>?> getInstitutions() async {
    return institutionApi.getInstitutions();
  }

  Future<InstitutionDTO?> addInstitution({required InstitutionPostDTO institution}) async {
    return institutionApi.createInstitution(institution);
  }

  Future<InstitutionDTO?> getInstitutionbyId({required String id}) async {
    return institutionApi.getInstitutionById(id);
  }

  Future<InstitutionDTO?> updateInstitution({required String id, required InstitutionPostDTO institution}) async {
    return institutionApi.updateInstitution(id, institution);
  }

  Future deleteInstitution({required String id}) async {
    await institutionApi.deleteInstitution(id);
  }

  Future importExerciseData(InstitutionImportDTO institutionImportDTO) async {
    return institutionApi.importExerciseData(institutionImportDTO);
  }
}
