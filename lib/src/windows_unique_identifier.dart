import 'dart:async';
import 'dart:io';
import 'package:unique_identifier_3/unique_identifier_3.dart';

class WindowsUniqueIdentifierPlugin extends UniqueIdentifierPlatform {
  static void registerWith([dynamic registrar]) {
    UniqueIdentifier.platform = WindowsUniqueIdentifierPlugin();
  }

  @override
  Future<String?> getUniqueIdentifier() async {
    try {
      final result = await Process.run(
        'reg',
        [
          'query',
          r'HKLM\SOFTWARE\Microsoft\Cryptography',
          '/v',
          'MachineGuid',
        ],
      );

      if (result.exitCode == 0) {
        final output = result.stdout.toString();
        final lines = output.split('\n');
        for (final line in lines) {
          if (line.contains('MachineGuid')) {
            final parts = line.split('    ');
            if (parts.length >= 3) {
              return parts.last.trim();
            }
          }
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
