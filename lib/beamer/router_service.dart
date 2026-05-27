import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

class RouterService {
  static String institutionsRoute() => '/institutions';
  static String institutionsAddRoute() => '/institutions/add';
  static String institutionsEditRoute({required String id}) {
    return '/institutions/$id/edit';
  }

  static String healthcareProfessionalsRoute({String? institutionId}) {
    final userRepo = KiwiContainer().resolve<UserRepository>();
    if (userRepo.userRole == UserRole.ADMINISTRATOR) {
      return '/institutions/$institutionId/healthcare-professionals';
    }
    return '/professionals';
  }

  static String healthcareProfessionalAddRoute({required String institutionId}) {
    final userRepo = KiwiContainer().resolve<UserRepository>();
    if (userRepo.userRole == UserRole.ADMINISTRATOR) {
      return '/institutions/$institutionId/healthcare-professionals/add';
    }
    return '/professionals/add';
  }

  static String healthcareProfessionalEditRoute({
    required String institutionId,
    required String healthcareProfessionalId,
  }) {
    final userRepo = KiwiContainer().resolve<UserRepository>();
    if (userRepo.userRole == UserRole.ADMINISTRATOR) {
      return '/institutions/$institutionId/healthcare-professionals/$healthcareProfessionalId/edit';
    }
    return '/professionals/$healthcareProfessionalId/edit';
  }

  static String patientsRoute({
    required String institutionId,
    required String healthcareProfessionalId,
  }) {
    final userRepo = KiwiContainer().resolve<UserRepository>();
    if (userRepo.userRole == UserRole.ADMINISTRATOR) {
      return '/institutions/$institutionId/healthcare-professionals/$healthcareProfessionalId/patients';
    } else if (userRepo.userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
      return '/patients';
    }
    return '/professionals/$healthcareProfessionalId/patients';
  }

  static String patientsEditRoute({
    required String institutionId,
    required String healthcareProfessionalId,
    required String patientId,
  }) {
    final userRepo = KiwiContainer().resolve<UserRepository>();
    if (userRepo.userRole == UserRole.ADMINISTRATOR) {
      return '/institutions/$institutionId/healthcare-professionals/$healthcareProfessionalId/patients/$patientId';
    } else if (userRepo.userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      return '/professionals/$healthcareProfessionalId/patients/$patientId/edit';
    } else if (userRepo.userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
      return '/patients/edit/$patientId';
    }
    return '/professionals/$healthcareProfessionalId/patients/$patientId';
  }

  static bool isActive(BuildContext context, String path) {
    return (context.currentBeamLocation.state as BeamState).uri.toString() == path;
  }

  static bool isDescendantActive(BuildContext context, String path) {
    return (context.currentBeamLocation.state as BeamState).uri.toString().startsWith(path);
  }
}
