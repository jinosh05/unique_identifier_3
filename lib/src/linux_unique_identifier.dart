import 'dart:async';
import 'dart:io';
import 'package:unique_identifier_3/unique_identifier_3.dart';

class LinuxUniqueIdentifierPlugin extends UniqueIdentifierPlatform {
  static void registerWith([dynamic registrar]) {
    UniqueIdentifier.platform = LinuxUniqueIdentifierPlugin();
  }

  @override
  Future<String?> getUniqueIdentifier() async {
    try {
      final machineIdFile = File('/etc/machine-id');
      if (await machineIdFile.exists()) {
        final machineId = await machineIdFile.readAsString();
        return machineId.trim();
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
