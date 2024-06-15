import 'dart:convert';
import 'package:glumate_flutter/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/errors/exceptions.dart';


abstract class UserLocalDataSource {
  Future<void>? cacheUser(UserModel? pokemonToCache);

  Future<UserModel> getConnectedUser();
  Future<void> deleteCache();
}

const cachedUser = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getConnectedUser() {
    final jsonString = sharedPreferences.getString(cachedUser);

    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheUser(UserModel? userToCache) async {
    try {
 if (userToCache != null) {
  
      sharedPreferences.setString(
        cachedUser,
        json.encode(
          userToCache,
        ),
      );
    }
    } catch (e) {
      print(e);
      throw CacheException();
    }
  
  }
  @override
  Future<void> deleteCache() async {
    try {

  
      sharedPreferences.clear();
    
    } catch (e) {
      print(e);
      throw CacheException();
    }
  
  }
}
