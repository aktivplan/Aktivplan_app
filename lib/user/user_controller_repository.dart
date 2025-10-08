// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:core';

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';
import 'package:http/http.dart';

class UserControllerRepository {
  final userApi = new UserControllerApi(apiClient);

  Future<FileGetDTO?> getUserPicture({required String id, required UserRole userRole}) async {
    return userApi.getUserPictureById(id, userRole);
  }

  Future<PatientsOverviewDTO?> getPatients({required String id}) async {
    return userApi.getPatientsOverview(healthcareProfessionalId: id);
  }

  Future<PatientOverviewDTO?> getPatientbyId({required String id}) async {
    return userApi.getPatientById(id);
  }

  Future<PatientGetDTO?> createPatient({required PatientGetDTO patient, MultipartFile? picture}) async {
    final PatientGetDTO? toReturn = await userApi.createPatient(PatientPostDTO(
        activityClass: patient.activityClass,
        birthDate: patient.birthDate,
        diseases: patient.diseases,
        email: patient.email,
        firstName: patient.firstName,
        healthcareProfessionalId: patient.healthcareProfessionalId,
        height: patient.height,
        lastName: patient.lastName,
        maximumBloodPressure: patient.maximumBloodPressure,
        maximumHeartRate: patient.maximumHeartRate,
        maximumOxygenConsumption: patient.maximumOxygenConsumption,
        maximumPerformance: patient.maximumPerformance,
        medication: patient.medication,
        weight: patient.weight));
    if (picture != null) {
      await userApi.uploadUserPictureById(toReturn!.id!, UserRole.PATIENT, picture);
    }
    return toReturn;
  }

  Future<PatientGetDTO?> updatePatient({required String id, required PatientGetDTO patient, MultipartFile? picture}) async {
    final PatientGetDTO? toReturn = await userApi.updatePatient(
        id,
        PatientPostDTO(
            activityClass: patient.activityClass,
            birthDate: patient.birthDate,
            diseases: patient.diseases,
            email: patient.email,
            firstName: patient.firstName,
            healthcareProfessionalId: patient.healthcareProfessionalId,
            height: patient.height,
            lastName: patient.lastName,
            maximumBloodPressure: patient.maximumBloodPressure,
            maximumHeartRate: patient.maximumHeartRate,
            maximumOxygenConsumption: patient.maximumOxygenConsumption,
            maximumPerformance: patient.maximumPerformance,
            medication: patient.medication,
            weight: patient.weight));
    if (picture != null) {
      await userApi.uploadUserPictureById(id, UserRole.PATIENT, picture);
    }
    return toReturn;
  }

  Future deletePatient({required String id}) async {
    await userApi.deletePatient(id);
  }

  Future<HealthcareProfessionalsOverviewDTO?> getHealthcareProfessionals({String? institutionId}) async {
    return userApi.getHealthcareProfessionalsOverview(institutionId: institutionId);
  }

  Future<HealthcareProfessionalProfileDTO?> getHealthcareProfessionalProfile(String senderId) async {
    return userApi.getHealthcareProfessionalProfile(senderId);
  }

  Future<HealthcareProfessionalGetDTO?> createHealthcareProfessional(
      {required HealthcareProfessionalGetDTO healthcareProfessional, MultipartFile? picture}) async {
    final HealthcareProfessionalGetDTO? toReturn = await userApi.createHealthcareProfessional(HealthcareProfessionalPostDTO(
        email: healthcareProfessional.email,
        firstName: healthcareProfessional.firstName,
        institutionId: healthcareProfessional.institutionId,
        jobName: healthcareProfessional.jobName,
        lastName: healthcareProfessional.lastName));
    if (picture != null) {
      await userApi.uploadUserPictureById(toReturn!.id!, UserRole.HEALTHCARE_PROFESSIONAL, picture);
    }
    return toReturn;
  }

  Future<HealthcareProfessionalGetDTO?> updateHealthcareProfessional(
      {required String id, required HealthcareProfessionalGetDTO healthcareProfessional, MultipartFile? picture}) async {
    final HealthcareProfessionalGetDTO? toReturn = await userApi.updateHealthcareProfessional(
        id,
        HealthcareProfessionalPostDTO(
            email: healthcareProfessional.email,
            firstName: healthcareProfessional.firstName,
            institutionId: healthcareProfessional.institutionId,
            jobName: healthcareProfessional.jobName,
            lastName: healthcareProfessional.lastName));
    if (picture != null) {
      await userApi.uploadUserPictureById(id, UserRole.HEALTHCARE_PROFESSIONAL, picture);
    }
    return toReturn;
  }

  Future deleteHealthcareProfessional({required String id}) async {
    await userApi.deleteHealthcareProfessional(id);
  }

  Future changeHealthcareProfessionalForPatients(ChangeHealthcareProfessionalDTO changeHealthcareProfessionalDTO) async {
    await userApi.changeHealthcareProfessionalForPatients(changeHealthcareProfessionalDTO);
  }
}
