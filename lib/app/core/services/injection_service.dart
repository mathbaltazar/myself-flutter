import 'package:flutter_modular/flutter_modular.dart';

class InjectorService {
  static T of<T extends Object>() {
    return Modular.get<T>();
  }
}