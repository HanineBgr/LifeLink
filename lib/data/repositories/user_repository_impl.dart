import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glumate_flutter/buisness/entities/user_entity.dart';
import 'package:glumate_flutter/buisness/repositories/user_repository_impl.dart';
import 'package:glumate_flutter/core/connection/networ_info.dart';
import 'package:glumate_flutter/core/errors/exceptions.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/local/user_local_data_source.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/data/datasources/remote/user_remote_data_source.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  

  final NetworkInfo networkInfo ;
  final UserRemoteDataSource userRemoteDataSource ;
   final UserLocalDataSource localDataSource;
  UserRepositoryImpl({
    required this.networkInfo ,
     required this.userRemoteDataSource , 
     required this.localDataSource});
  @override
  Future<void> patientRegister({required PatientRequest body}) async{


  if (await networkInfo.isConnected!){
    try{
      await userRemoteDataSource.patientRegister(body: body);
            
     } on EmailExistsFailure {

      throw EmailExistsFailure();
    }
    on ServerFailure {

      throw ServerFailure();

    }  on AppFailure {

      throw AppFailure();

    }
  } else {
      throw NetworkFailure();

  }
  }


@override
  Future<Either<Failure, UserEntity>> userLogin({required UserLoginRequest body}) async {
 

  if (!(await networkInfo.isConnected!)) {
    return Left(NetworkFailure());
  }

  try {
   
   final remoteUser = await Auth().signInWithEmailAndPassword(email: body.email, password: body.password);
print("how");
    return Right(remoteUser);
  } on FireBaseAuthFailure  {
    return Left(FireBaseAuthFailure(errorMessage: "Incorrect Email/password"));
  } on ServerFailure {
    return Left(ServerFailure());
  } on CacheFailure {
    return Left(AppFailure());
  } catch (_) {
    return Left(AppFailure());
  }
}

  
  @override
  Future<void> userLogout() async {

    if (await networkInfo.isConnected!){
      
        await Auth().signOut();
  
  } else {
   throw NetworkFailure();  
  }
    
  }


// get user from server if it's needed
  @override
  Future<Either<Failure, UserEntity>> getUserByUid({required String params}) async {
    
    if (await networkInfo.isConnected!) {
      try {
       
        final remoteUser =
            await userRemoteDataSource.getUser(uid: params);
        localDataSource.cacheUser(remoteUser);

        return Right(remoteUser);
      } on ServerFailure {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure(errorMessage: "cache error"));
      }
     } else {
 
    return Left(NetworkFailure());
     }
  } 

  @override
    Future<Either<Failure, UserEntity>> getCachedUser() async {
    
      try {
       
        final cachedUser =
            await localDataSource!.getConnectedUser();
        return Right(cachedUser);
      }  on CacheException {
        return Left(CacheFailure(errorMessage: "cache error"));
      }
     
  } 

  @override
  Future<void> deleteCache() async {
    
      try {
            await localDataSource.deleteCache();
       
      }  on CacheException {
        throw (CacheFailure(errorMessage: "cache error"));
      }
     
  }
  
 
  @override
  Future<void> doctorRegister({required DoctorRequest body}) async{
    if (await networkInfo.isConnected!){
    try{
      await userRemoteDataSource.doctorRegister(body: body);
            
     } on EmailExistsFailure {

      throw EmailExistsFailure();
    }
    on ServerFailure {

      throw ServerFailure();

    }  on AppFailure {

      throw AppFailure();

    }
  } else {
      throw NetworkFailure();

  }
  }
  
  @override
Future<Either<Failure, UserEntity>> updateUser({required String userId, required Map<String, dynamic> updateUserFields}) async {
  if (await networkInfo.isConnected!) {
    try {
      await userRemoteDataSource.updateUser(userId: userId, updateUserFields: updateUserFields);
    } on EmailExistsFailure {
      throw EmailExistsFailure();
    } on ServerFailure {
      throw ServerFailure();
    } on AppFailure {
      throw AppFailure();
    }
  } else {
    throw NetworkFailure();
  }
  
  throw AppFailure();
}

}