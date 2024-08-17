import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff/app/core/constants/route_constants.dart';
import 'package:myselff/app/core/services/injection_service.dart';

import 'data/datasources/user_data_source.dart';
import 'data/datasources/user_data_source_impl.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/repository/user_repository.dart';
import 'domain/usecases/user_use_cases.dart';
import 'presentation/controllers/user_controller.dart';
import 'presentation/pages/user_page.dart';

class UserModule extends Module {
  @override
  void binds(i) {
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);
    i.addSingleton<UserDataSource>(UserDataSourceImpl.new);
    i.addSingleton<UserRepository>(UserRepositoryImpl.new);
    i.addSingleton(UserUseCases.new);
    i.add(UserController.new);
  }

  @override
  void routes(r) {
    r.child(
      RouteConstants.initialRoute,
      child: (_) => UserPage(controller: InjectorService.of<UserController>()),
    );
  }
}
