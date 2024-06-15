import 'package:dartz/dartz.dart';
import 'package:glumate_flutter/buisness/entities/user_entity.dart';
import 'package:glumate_flutter/buisness/repositories/user_repository_impl.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class UserLogin {
  final UserRepository repository;

  UserLogin(this.repository);

  Future<Either<Failure, UserEntity>> callUserLogin({required UserLoginRequest userLoginRequest}) async {
     return await repository.userLogin(body: userLoginRequest);
  }


  Future<void> callUserLogout() async {
     await repository.userLogout();
     await repository.deleteCache();
  }
      Future<Either<Failure, UserEntity>> callUserByUid({required String params}) async {
    return await repository.getUserByUid(params: params);
  }
        Future<Either<Failure, UserEntity>> getCachedUser() async {
    return await repository.getCachedUser();
  }
}