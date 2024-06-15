

import 'package:dartz/dartz.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/buisness/repositories/gluc_repository.dart';

import 'package:glumate_flutter/core/connection/networ_info.dart';
import 'package:glumate_flutter/core/errors/failure.dart';

import 'package:glumate_flutter/data/datasources/remote/gluc_remote_data_source.dart';

import 'package:glumate_flutter/data/models/gluc_model.dart';


class GlucRepositoryImpl implements GlucRepository {
  

  final NetworkInfo networkInfo ;
  final GlucRemoteDataSource glucRemoteDataSource ;
  
  GlucRepositoryImpl({required this.networkInfo , required this.glucRemoteDataSource });


  @override
  Future<void> manualRecord({required String token,required ManuelRequest body}) async {
   if (await networkInfo.isConnected!){
    try{
      await glucRemoteDataSource.manuelRecord(token: token ,body: body);
            
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
  Future<Either<Failure, List<GlucEntity>>> fetchRecords({required String token, required String id}) async {
 if (await networkInfo.isConnected!) {
      try {
        final remoteRecords =
            await glucRemoteDataSource.fetchRecords(token: token , id: id);

       // localDataSource.cacheRecords(remoteRecords);

        return Right(remoteRecords);
      } on ServerFailure {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      } on AppFailure {
        return Left(AppFailure());
      }
    } else {
      // try {
      //   final localPokemon = await localDataSource.getLastPokemon();
      //   return Right(localPokemon);
      // } on CacheException {
      //   return Left(CacheFailure(errorMessage: 'No local data found'));
      // }
      return Left(NetworkFailure());
    }
  }


}