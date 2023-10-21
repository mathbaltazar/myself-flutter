import 'package:flutter_modular/flutter_modular.dart';

class Injector {
  static T of<T extends Object>() {
    return Modular.get<T>();
  }
}