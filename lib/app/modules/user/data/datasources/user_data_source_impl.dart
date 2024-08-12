import 'package:firebase_auth/firebase_auth.dart';

import 'user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> authWithGoogle({
    String? idToken,
    String? accessToken,
  }) async {
    try {
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (_) {
      throw 'Erro ao obter usuário';
    }
  }

  @override
  Future<User?> logoutFromGoogle() async {
    try {
      await _firebaseAuth.signOut();
      return _firebaseAuth.currentUser;
    } catch (_) {
      throw 'Erro ao deslogar o usuário';
    }
  }
}
