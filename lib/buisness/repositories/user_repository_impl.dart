

import 'package:dartz/dartz.dart';
import 'package:glumate_flutter/buisness/entities/user_entity.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> patientRegister({required PatientRequest body});
  Future<void> doctorRegister({required DoctorRequest body});
  Future<Either<Failure, UserEntity>> userLogin({required UserLoginRequest body});
  Future<void> userLogout();
  Future<Either<Failure, UserEntity>> getUserByUid({required String params});
  Future<Either<Failure, UserEntity>> getCachedUser();
  Future<void> deleteCache() ;
  Future<Either<Failure, UserEntity>> updateUser({required String userId, required Map<String, dynamic> updateUserFields});

}