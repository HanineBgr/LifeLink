abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({String errorMessage = 'Server Error , try again later'}) : super(errorMessage: errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class FireBaseAuthFailure extends Failure {
  FireBaseAuthFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class EmailExistsFailure extends Failure {
  EmailExistsFailure({String errorMessage = 'it seems that you already have an account'}) : super( errorMessage: errorMessage);
}


class AppFailure extends Failure {
  AppFailure({String errorMessage = 'Error occured , try again'}) : super( errorMessage: errorMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure({String errorMessage = 'No Internet connexion , Please verify your Internet connexion'}) : super( errorMessage: errorMessage);
}