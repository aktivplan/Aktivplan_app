// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:apt_api/api.dart';
import 'package:test/test.dart';

/// tests for UserControllerApi
void main() {
  // final instance = UserControllerApi();

  group('tests for UserControllerApi', () {
    //Future changeHealthcareProfessionalForPatients(ChangeHealthcareProfessionalDTO changeHealthcareProfessionalDTO) async
    test('test changeHealthcareProfessionalForPatients', () async {
      // TODO
    });

    // createHealthcareProfessional
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
    //
    //Future<HealthcareProfessionalGetDTO> createHealthcareProfessional({ String email, String institutionId, String firstName, String lastName, String jobName, MultipartFile pictureFile }) async
    test('test createHealthcareProfessional', () async {
      // TODO
    });

    // createHealthcareProfessional
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
    //
    //Future<HealthcareProfessionalGetDTO> createHealthcareProfessionalWithoutImage(HealthcareProfessionalPostDTO healthcareProfessionalPostDTO) async
    test('test createHealthcareProfessionalWithoutImage', () async {
      // TODO
    });

    // createPatient
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<PatientGetDTO> createPatient({ String email, String healthcareProfessionalId, String consentId, String firstName, String lastName, String birthDate, int height, int weight, int activityClass, int maximumHeartRate, String maximumBloodPressure, double maximumPerformance, double maximumOxygenConsumption, String diseases, String medication, PatientState patientState, String patientNotes, MultipartFile pictureFile }) async
    test('test createPatient', () async {
      // TODO
    });

    // createPatient
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<PatientGetDTO> createPatientWithoutImage(PatientPostDTO patientPostDTO) async
    test('test createPatientWithoutImage', () async {
      // TODO
    });

    // deleteHealthcareProfessional
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
    //
    //Future deleteHealthcareProfessional(String id) async
    test('test deleteHealthcareProfessional', () async {
      // TODO
    });

    // deletePatient
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future deletePatient(String id) async
    test('test deletePatient', () async {
      // TODO
    });

    //Future deleteUserPictureById(String id) async
    test('test deleteUserPictureById', () async {
      // TODO
    });

    //Future<bool> existsEmail(String email, { String existingUserId }) async
    test('test existsEmail', () async {
      // TODO
    });

    //Future<CreatePatientConsentDTO> getCreatePatientConsentText() async
    test('test getCreatePatientConsentText', () async {
      // TODO
    });

    // updateHealthcareProfessional
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<HealthcareProfessionalGetDTO> getHealthcareProfessionalById(String id) async
    test('test getHealthcareProfessionalById', () async {
      // TODO
    });

    // getHealthcareProfessionalProfile
    //
    // PATIENT
    //
    //Future<HealthcareProfessionalProfileDTO> getHealthcareProfessionalProfile(String id) async
    test('test getHealthcareProfessionalProfile', () async {
      // TODO
    });

    // getHealthcareProfessionalsOverview
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
    //
    //Future<HealthcareProfessionalsOverviewDTO> getHealthcareProfessionalsOverview({ String institutionId }) async
    test('test getHealthcareProfessionalsOverview', () async {
      // TODO
    });

    //Future<PatientOverviewDTO> getPatientById(String id) async
    test('test getPatientById', () async {
      // TODO
    });

    //Future<List<bool>> getPatientCheckMarks(String id) async
    test('test getPatientCheckMarks', () async {
      // TODO
    });

    //Future<PatientNotesDTO> getPatientNotes(String id) async
    test('test getPatientNotes', () async {
      // TODO
    });

    //Future<InstitutionCountDTO> getPatientUserCountByHealthcareProfessionalId(String id) async
    test('test getPatientUserCountByHealthcareProfessionalId', () async {
      // TODO
    });

    // getPatientsOverview
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<PatientsOverviewDTO> getPatientsOverview({ String healthcareProfessionalId }) async
    test('test getPatientsOverview', () async {
      // TODO
    });

    //Future<UserPictureGetDTO> getUserPictureById(String id) async
    test('test getUserPictureById', () async {
      // TODO
    });

    // requestHealthDataChange
    //
    // PATIENT
    //
    //Future requestHealthDataChange(HealthDataChangeDTO healthDataChangeDTO) async
    test('test requestHealthDataChange', () async {
      // TODO
    });

    // requestProfileDeletion
    //
    // PATIENT
    //
    //Future requestProfileDeletion() async
    test('test requestProfileDeletion', () async {
      // TODO
    });

    // sendPatientWelcomeMail
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<PatientGetDTO> sendPatientWelcomeMail(String id) async
    test('test sendPatientWelcomeMail', () async {
      // TODO
    });

    //Future storePatientCheckMarks(String id, List<bool> requestBody) async
    test('test storePatientCheckMarks', () async {
      // TODO
    });

    //Future storePatientNotes(String id, PatientNotesDTO patientNotesDTO) async
    test('test storePatientNotes', () async {
      // TODO
    });

    //Future storePatientState(String id, PatientStateDTO patientStateDTO) async
    test('test storePatientState', () async {
      // TODO
    });

    // updateHealthcareProfessional
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<HealthcareProfessionalGetDTO> updateHealthcareProfessional(String id, { String email, String institutionId, String firstName, String lastName, String jobName, MultipartFile pictureFile }) async
    test('test updateHealthcareProfessional', () async {
      // TODO
    });

    // updateHealthcareProfessional
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<HealthcareProfessionalGetDTO> updateHealthcareProfessionalWithoutImage(String id, HealthcareProfessionalPostDTO healthcareProfessionalPostDTO) async
    test('test updateHealthcareProfessionalWithoutImage', () async {
      // TODO
    });

    //Future<PatientGetDTO> updatePatient(String id, { String email, String healthcareProfessionalId, String consentId, String firstName, String lastName, String birthDate, int height, int weight, int activityClass, int maximumHeartRate, String maximumBloodPressure, double maximumPerformance, double maximumOxygenConsumption, String diseases, String medication, PatientState patientState, String patientNotes, MultipartFile pictureFile }) async
    test('test updatePatient', () async {
      // TODO
    });

    //Future<PatientGetDTO> updatePatientWithoutImage(String id, PatientPostDTO patientPostDTO) async
    test('test updatePatientWithoutImage', () async {
      // TODO
    });

    //Future<UserPictureGetDTO> uploadUserPictureById(String id, MultipartFile pictureFile) async
    test('test uploadUserPictureById', () async {
      // TODO
    });
  });
}
