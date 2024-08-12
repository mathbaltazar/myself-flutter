import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataSource {
  Future<User?> authWithGoogle({String? idToken, String? accessToken});
  Future<User?> getUser();
  Future<User?> logoutFromGoogle();
}