import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:myselff_flutter/app/modules/user/domain/entity/user_entity.dart';
import 'package:myselff_flutter/app/modules/user/domain/usecases/user_use_cases.dart';
import 'package:signals/signals.dart';

class UserController {
  UserController(this.userUseCases);

  final UserUseCases userUseCases;

  final loading = signal(false);
  final user = signal(UserEntity());

  getUser() async {
    try {
      loading.set(true);

      final result = await userUseCases.getUser();

      result.fold(
        (error) => MessageService.showErrorMessage(error.toString()),
        (userEntity) => user.set(userEntity),
      );
    } catch (_) {
      rethrow;
    } finally {
      loading.set(false);
    }
  }

  onLoginWithGoogleClicked() async {
    try {
      loading.set(true);

      final result = await userUseCases.loginWithGoogle();

      result.fold(
        (error) => MessageService.showErrorMessage(error.toString()),
        (userEntity) async {
          user.set(userEntity);

          if (userEntity.authenticated) {
            MessageService.showMessage('Usuário autenticado!');
          } else {
            MessageService.showErrorMessage('Autenticação não sucedida...');
          }
        },
      );

      loading.set(false);
    } catch (_) {
      rethrow;
    }
  }

  onLogoutButtonClicked() async {
    loading.set(true);

    try {
      final result = await userUseCases.logoutFromGoogle();

      result.fold(
        (error) => MessageService.showErrorMessage(error.toString()),
        (userEntity) {
          user.set(userEntity);
          MessageService.showMessage('Usuário deslogado');
        },
      );

      loading.set(false);
    } catch (_) {
      rethrow;
    }
  }
}
