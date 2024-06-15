import 'package:dartz/dartz.dart';
import 'package:glumate_flutter/buisness/entities/user_entity.dart';
import 'package:glumate_flutter/buisness/repositories/user_repository_impl.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class PatientRegister {
  final UserRepository repository;

  PatientRegister(this.repository);

  Future<void> callPatientRegister({required PatientRequest patientRegisterRequest}) async {
     await repository.patientRegister(body: patientRegisterRequest);
  }


}