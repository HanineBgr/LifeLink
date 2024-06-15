import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glumate_flutter/core/errors/exceptions.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/local/user_local_data_source.dart';
import 'package:glumate_flutter/data/datasources/remote/user_remote_data_source.dart';
import 'package:glumate_flutter/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;



Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

 Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  
       final userRemoteDataSource = UserRemoteDataSourceImpl(dio: Dio(BaseOptions(
  connectTimeout: const Duration(milliseconds: 500), 
  receiveTimeout: const Duration(milliseconds: 500), 
)));
      final userLocalDataSource = UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
      final remoteUser = await userRemoteDataSource.getUser(uid: Auth().currentUser!.uid);
      await userLocalDataSource.cacheUser(remoteUser);
      return remoteUser;
    } on FirebaseAuthException catch (e) {
      print('FireBaseAuth Error : ${e.code} ; message : ${e.message}');
      throw FireBaseAuthFailure(errorMessage: e.message!);
    } on ServerFailure catch(e) {
       await _firebaseAuth.signOut();
      throw ServerFailure();
    } on CacheException catch(e) {
       await _firebaseAuth.signOut();
      throw AppFailure();
    } on TimeoutException catch (e) {
      throw ServerFailure();
    } catch (e) {
       await _firebaseAuth.signOut();
      print('Unexpected error: $e');
      throw AppFailure();
    }
  }

Future<void> signOut() async {
  
  await _firebaseAuth.signOut();

}

}