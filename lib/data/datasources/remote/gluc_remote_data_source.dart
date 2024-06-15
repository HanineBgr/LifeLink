

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glumate_flutter/core/config.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/gluc_model.dart';


abstract class GlucRemoteDataSource {
  Future<void> manuelRecord({required String token,required ManuelRequest body });
Future<List<GlucModel>> fetchRecords({required String token , required String id});

}


class GlucRemoteDataSourceImpl implements GlucRemoteDataSource {
final Dio dio ;

GlucRemoteDataSourceImpl({required this.dio});


  @override
Future<void> manuelRecord({required String token,required ManuelRequest body}) async {
const manuelRecordURL = "${AppConfig.baseUrl}glucose/manual" ;
try {
dio.options.headers["Authorization"] = "$token";
await dio.post ( manuelRecordURL , data: body.toJson());

} on DioException catch (e){
print(e);

      throw ServerFailure();
 
}


catch (e){
  print(e);
      throw AppFailure();
}

  }
  
  @override
  Future<List<GlucModel>> fetchRecords({required String token, required String id}) async {
    List<GlucModel> records = [];
    String fecthRecordURL = "${AppConfig.baseUrl}glucose/$id" ;
    try{
      dio.options.headers["Authorization"] = "$token";
    final response = await dio.get(fecthRecordURL);
    print(fecthRecordURL);
        if (response.statusCode == 200) {
          final List<dynamic> responseData = response.data;
          records = responseData.map((data) => GlucModel.fromJson(data)).toList();
      return records;
    } else {
      throw ServerFailure();
  }
  
    } on DioException catch (e){
       print(e);

  if (e.response != null && e.response!.statusCode == 500) {
      print('Error in fetching records: ${e.response!.statusCode}');
      throw ServerFailure();
    } 
} catch (e) {
      print(e);
     throw AppFailure() ;
}

throw AppFailure();
    }
   

  }
