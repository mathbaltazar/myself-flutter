import 'package:flutter_modular/flutter_modular.dart';

class DependencyProvider {

  static T of<T extends Object>() {
    return Modular.get<T>();
  }
}