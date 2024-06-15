import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/buisness/entities/user_entity.dart';
import 'package:glumate_flutter/buisness/usecases/doctor_register.dart';
import 'package:glumate_flutter/buisness/usecases/patient_register.dart';
import 'package:glumate_flutter/buisness/usecases/user_login.dart';
import 'package:glumate_flutter/core/connection/networ_info.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/local/user_local_data_source.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/data/datasources/remote/user_remote_data_source.dart';
import 'package:glumate_flutter/data/models/user_model.dart';
import 'package:glumate_flutter/data/repositories/user_repository_impl.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterAuthProvider extends ChangeNotifier {
  Failure? failure;
  UserEntity? user;
  RegisterAuthProvider({
    this.failure,
    this.user,
  });
  UserEntity? _cachedUser;
  bool _isLoading = false;
  String _userId = "";
  String _errorRegisterMessage = "";
  String _errorLogoutMessage = "";
  String _errorLoginMessage = "";
  String get errorRegisterMessage => _errorRegisterMessage;
  String get errorLoginMessage => _errorLoginMessage;
  String get errorLogoutMessage => _errorLogoutMessage;
  String get userId => _userId;
  UserEntity? get cachedUser => _cachedUser ;
  bool get isLoading => _isLoading;
  
  
  void setUserId(String id) {
    _setUserId(id);
  }

  void _setUserId(String id){
    _userId = id;
    notifyListeners();
  }
  void setRegisterErrorMessage(String newError) {
    _setErrorRegisterMessage(newError);
  }

  void setLoginErrorMessage(String newError) {
    _setErrorLoginMessage(newError);
  }

  void setLogoutErrorMessage(String newError) {
    _setErrorLogoutMessage(newError);
  }
  void _setErrorRegisterMessage(String newError) {
    _errorRegisterMessage = newError;
    notifyListeners();
  }

  void _setErrorLoginMessage(String newError) {
    _errorLoginMessage = newError;
    notifyListeners();
  }
    void _setErrorLogoutMessage(String newError) {
    _errorLoginMessage = newError;
    notifyListeners();
  }

  Future<void> eitherFailureOrRegister({
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
    required TextEditingController password,
    required int selectedgender,
    required DateTime selectedDate, required int selectedGender,
  }) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
         localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance())

    );

    final String gender = selectedgender == 1 ? 'male' : 'female';
    final String dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);
setRegisterErrorMessage("");
    try {
      await PatientRegister(repository).callPatientRegister(
        patientRegisterRequest: PatientRequest(
          firstName: firstName.text,
          email: email.text,
          lastName: lastName.text,
          password: password.text,
          gender: gender,
          dateOfBirth: dateOfBirth,
        ),
      );
    } on EmailExistsFailure {
      setRegisterErrorMessage(EmailExistsFailure().errorMessage);
    } on NetworkFailure {
      setRegisterErrorMessage(NetworkFailure().errorMessage);
    } on ServerFailure {
      setRegisterErrorMessage(ServerFailure().errorMessage);
    } on AppFailure {
      setRegisterErrorMessage(AppFailure().errorMessage);
    }
  }
// register provider 
Future<void> eitherFailureOrRegisterCareProvider({
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController phone,
  }) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
         localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance())

    );

    try {
      await DoctorRegister(repository).callDoctorRegister(
        doctorRegisterRequest: DoctorRequest(
          firstName: firstName.text,
          email: email.text,
          lastName: lastName.text,
          password: password.text,
          phone: phone.text , 
        ),
      );
    } on EmailExistsFailure {
      setRegisterErrorMessage(EmailExistsFailure().errorMessage);
    } on NetworkFailure {
      setRegisterErrorMessage(NetworkFailure().errorMessage);
    } on ServerFailure {
      setRegisterErrorMessage(ServerFailure().errorMessage);
    } on AppFailure {
      setRegisterErrorMessage(AppFailure().errorMessage);
    }
  }
  Future<Either<Failure, UserEntity>> eitherFailureOrLogin({
    required TextEditingController email,
    required TextEditingController passsword,
  }) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
            localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance())

    );
    setLoginErrorMessage("");
     final connectedUser =  await UserLogin(repository).callUserLogin(
        userLoginRequest: UserLoginRequest(
          email: email.text,
          password: passsword.text,
        ),
      );
       return connectedUser.fold(
    (newFailure) {
      user = null;
      failure = newFailure;
      _isLoading = false;
     print(newFailure.errorMessage);
        setLoginErrorMessage(newFailure.errorMessage);
      notifyListeners();
      return Left(newFailure);
    },
    (newUser) {
      user = newUser;
      failure = null;
      _isLoading = false;
     notifyListeners();
      return Right(newUser);
    },
  );
  
  }

  Future<void> eitherFailureOrLogout() async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
            localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance())

    );
    setLogoutErrorMessage("");

    try { 
      await UserLogin(repository).callUserLogout();
      
    }  on NetworkFailure {
      setLogoutErrorMessage(NetworkFailure().errorMessage);
    } on AppFailure {
      setLogoutErrorMessage(AppFailure().errorMessage);
    }
  }

  Future<Either<Failure, UserEntity>> eitherFailureOrConnectedUser() async {
  UserRepositoryImpl repository = UserRepositoryImpl(
    userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance())
    
  );
_isLoading = true;
notifyListeners();
  setLoginErrorMessage("");
  final connectedUser = await UserLogin(repository).callUserByUid(
    params: Auth().currentUser!.uid,
  );

  return connectedUser.fold(
    (newFailure) {
      user = null;
      failure = newFailure;
      _isLoading = false;
        setLoginErrorMessage("internal server error");
      notifyListeners();
    
      return Left(newFailure);
    },
    (newUser) {
      user = newUser;
      failure = null;
      _isLoading = false;
     notifyListeners();
      return Right(newUser);
    },
  );

}
  Future<void> eitherFailureOrUpdateUser({
    required String id,
    required Map<String, dynamic> updatedUserData,
  }) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance()),
    );

    try {
      await repository.updateUser(userId: id, updateUserFields: updatedUserData);
    } on NetworkFailure {
      setLoginErrorMessage(NetworkFailure().errorMessage);
    } on ServerFailure {
      setLoginErrorMessage(ServerFailure().errorMessage);
    } on AppFailure {
      setLoginErrorMessage(AppFailure().errorMessage);
    }
  }

Future<Either<Failure, UserEntity>> eitherFailureOrConnectedCachedUser() async {
  if (_cachedUser != null) {
    return Right(_cachedUser!);
  } else {
    final UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: UserLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance())
    );
_isLoading = true;
notifyListeners();
    final cachedUser = await UserLogin(repository).getCachedUser();
    return cachedUser.fold(
      (newFailure) {
        user = null;
        failure = newFailure;
        _isLoading = false;
        notifyListeners();
        return Left(newFailure);
      },
      (newUser) {
        user = newUser;
        failure = null;
        _cachedUser = newUser;
          _isLoading = false;
        notifyListeners();
        return Right(newUser);
      },
    );
  }
  
}

}
