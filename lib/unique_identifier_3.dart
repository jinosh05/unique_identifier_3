
import 'unique_identifier_3_platform_interface.dart';

class UniqueIdentifier_3 {
  Future<String?> getPlatformVersion() {
    return UniqueIdentifier_3Platform.instance.getPlatformVersion();
  }
}
