

import 'package:dartz/dartz.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/gluc_model.dart';


abstract class GlucRepository {
  Future<void> manualRecord({required String token,required ManuelRequest body});  
  Future<Either<Failure,List<GlucEntity>>> fetchRecords({required String token,required String id});  
}