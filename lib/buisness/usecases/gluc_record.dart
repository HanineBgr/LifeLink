import 'package:dartz/dartz.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/buisness/repositories/gluc_repository.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/gluc_model.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class GlucRecord {
  final GlucRepository repository;

   GlucRecord (this.repository);

  Future<void> callManualRecord({required String token,required ManuelRequest manuelRequest}) async {
     await repository.manualRecord( token: token ,body: manuelRequest);
  }

    Future<Either<Failure,List<GlucEntity>>> callFetchRecords({required String token,required String id}) async {
    return  await repository.fetchRecords( token: token ,id: id);
  }
}