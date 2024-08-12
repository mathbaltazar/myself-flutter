import 'package:firebase_auth/firebase_auth.dart';

class RemoteException implements Exception {
  const RemoteException({
    this.code,
    this.message,
  });

  final String? code;
  final String? message;

  factory RemoteException.fromFirebaseException(FirebaseException e) {
    return RemoteException(code: e.code, message: e.message);
  }

  @override
  String toString() => '$message';
}
