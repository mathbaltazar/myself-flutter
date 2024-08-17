import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myselff/app/core/exceptions/remote_exception.dart';
import 'package:myselff/app/modules/user/data/datasources/user_data_source.dart';
import 'package:myselff/app/modules/user/data/mappers/firebase_user_mapper_extensions.dart';
import 'package:myselff/app/modules/user/domain/entity/user_entity.dart';
import 'package:myselff/app/modules/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDataSource);

  final UserDataSource _userDataSource;

  @override
  Future<Either<RemoteException, UserEntity>> authWithGoogle({
    String? accessToken,
    String? idToken,
  }) async {
    try {
      final result = await _userDataSource.authWithGoogle(
          accessToken: accessToken, idToken: idToken);
      return Right(result.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(RemoteException.fromFirebaseException(e));
    } on FirebaseException catch (e) {
      return Left(RemoteException.fromFirebaseException(e));
    } catch (_) {
      return const Left(RemoteException(message: 'Não foi possível realizar a autenticação'));
    }
  }

  @override
  Future<Either<RemoteException, UserEntity>> getUser() async {
    try {
      final result = await _userDataSource.getUser();

      return Right(result.toEntity());
    } catch (e) {
      return Left(RemoteException(message: e.toString()));
    }
  }

  @override
  Future<Either<RemoteException, UserEntity>> logoutFromGoogle() async {
    try {
      final result = await _userDataSource.logoutFromGoogle();
      return Right(result.toEntity());
    } catch (e) {
      return Left(RemoteException(message: e.toString()));
    }
  }
}
