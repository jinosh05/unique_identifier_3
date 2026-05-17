import 'dart:async';
import 'dart:io';
import 'package:unique_identifier_3/unique_identifier_3.dart';

class MacosUniqueIdentifierPlugin extends UniqueIdentifierPlatform {
  static void registerWith([dynamic registrar]) {
    UniqueIdentifier.platform = MacosUniqueIdentifierPlugin();
  }

  @override
  Future<String?> getUniqueIdentifier() async {
    try {
      final result = await Process.run(
        'ioreg',
        ['-rd1', '-c', 'IOPlatformExpertDevice'],
      );

      if (result.exitCode == 0) {
        final output = result.stdout.toString();
        final match = RegExp(r'"IOPlatformUUID" = "([^"]+)"').firstMatch(output);
        if (match != null) {
          return match.group(1);
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
