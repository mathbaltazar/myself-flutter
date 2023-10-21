import 'package:uuid/uuid.dart';

class DomainUtils {
  static const Uuid _uuid = Uuid();

  static String nextId() {
    return _uuid.v4().toString();
  }
}
