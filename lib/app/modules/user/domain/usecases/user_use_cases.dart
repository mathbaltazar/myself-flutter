import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myselff_flutter/app/core/exceptions/remote_exception.dart';
import 'package:myselff_flutter/app/modules/user/domain/entity/user_entity.dart';
import 'package:myselff_flutter/app/modules/user/domain/repository/user_repository.dart';

class UserUseCases {
  UserUseCases(this._repository);

  final UserRepository _repository;

  Future<Either<RemoteException, UserEntity>> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn(forceCodeForRefreshToken: true).signIn();
    final auth = await googleAccount?.authentication;

    return await _repository.authWithGoogle(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
  }

  Future<Either<Exception, UserEntity>> getUser() async {
    return _repository.getUser();
  }

  Future<Either<Exception, UserEntity>> logoutFromGoogle() async {
    await GoogleSignIn().signOut();
    return await _repository.logoutFromGoogle();
  }
}
