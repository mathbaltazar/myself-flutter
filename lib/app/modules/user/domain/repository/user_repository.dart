import 'package:fpdart/fpdart.dart';
import 'package:myselff/app/core/exceptions/remote_exception.dart';
import 'package:myselff/app/modules/user/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<RemoteException, UserEntity>> authWithGoogle({String? accessToken, String? idToken});
  Future<Either<RemoteException, UserEntity>> getUser();
  Future<Either<RemoteException, UserEntity>> logoutFromGoogle();
}
