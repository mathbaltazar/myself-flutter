import 'package:firebase_auth/firebase_auth.dart';
import 'package:myselff_flutter/app/modules/user/domain/entity/user_entity.dart';

extension FirebaseUserMapperExtension on User? {
  UserEntity toEntity() {
    return UserEntity(
          name: this?.displayName,
          email: this?.email,
          imageUrl: this?.photoURL,
          authenticated: this != null);
  }
}