import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';

class LoginController {
  final loading = ValueNotifier(false);

  Future<void> loginWithGoogle() async {
    loading.value = true;
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
        Modular.to.pushReplacementNamed(AppRoutes.expenseRoute);
      }
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.toString());
      MessageService.showMessage(
          exception.message ?? 'Erro ao autenticar usuário');
    } catch (exception) {
      debugPrint(exception.toString());
      MessageService.showMessage('Erro ao autenticar usuário');
    } finally {
      loading.value = false;
    }
  }

  void continueWithoutLogin() {
    Modular.to.pushReplacementNamed(AppRoutes.expenseRoute);
  }

  void checkLogin() {
    loading.value = true;
    if (FirebaseAuth.instance.currentUser != null) {
      Modular.to.pushReplacementNamed(AppRoutes.expenseRoute);
    }
    loading.value = false;
  }
}
