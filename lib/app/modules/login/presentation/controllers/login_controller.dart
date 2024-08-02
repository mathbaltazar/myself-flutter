import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:signals/signals.dart';

class LoginController {
  final loading = signal(false);

  Future<void> loginWithGoogle() async {
    loading.set(true);
    try {
      final googleAccount = await GoogleSignIn().signIn();

      final googleAuth = await googleAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Modular.to.pushReplacementNamed(RouteConstants.expenseRoute);
      }
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.toString());
      MessageService.showErrorMessage(
          exception.message ?? 'Erro ao autenticar usuário');
    } catch (exception) {
      debugPrint(exception.toString());
      MessageService.showErrorMessage('Erro ao autenticar usuário');
    } finally {
      loading.set(false);
    }
  }

  void continueWithoutLogin() {
    Modular.to.pushReplacementNamed(RouteConstants.expenseRoute);
  }

  void checkLogin() {
    loading.set(true);
    if (FirebaseAuth.instance.currentUser != null) {
      Modular.to.pushReplacementNamed(RouteConstants.expenseRoute);
    }
    loading.set(false);
  }
}
