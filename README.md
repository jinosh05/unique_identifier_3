
```markdown
# Unique Identifier

[![pub package](https://img.shields.io/badge/pub-0.3.0-green.svg)](https://pub.dartlang.org/packages/unique_identifier_3)

A Flutter plugin to retrieve the `ANDROID_ID` for Android devices and `identifierForVendor` for iOS devices. This unique identifier allows you to track devices in a secure and platform-compliant way.

## Installation

To add this package to your project, update the dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  unique_identifier_3: ^0.0.1
```

### Import the Package

```dart
import 'package:unique_identifier_3/unique_identifier_3.dart';
```

## Usage

### Example Code

The following example demonstrates how to retrieve a unique identifier for the device and display it in a Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:unique_identifier_3/unique_identifier_3.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _identifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUniqueIdentifier();
  }

  // Method to initialize and retrieve the unique identifier
  Future<void> initUniqueIdentifier() async {
    String identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unique Identifier Example'),
        ),
        body: Center(
          child: Text('Device ID: $_identifier\n'),
        ),
      ),
    );
  }
}
```

## iOS App Tracking Transparency

If your app uses tracking on iOS, ensure that you request App Tracking Transparency (ATT) permission from users. The following code includes permission handling and a custom dialog prompt for iOS:

```dart
import 'package:flutter/material.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

Future<void> initTrackingTransparency(BuildContext context) async {
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;

  if (status == TrackingStatus.notDetermined || status == TrackingStatus.denied) {
    // Show a custom dialog before the system's tracking dialog
    await showCustomTrackingDialog(
      context,
      'We use tracking to enhance your experience and provide personalized content and ads. '
      'Please consider enabling tracking for improved service.',
    );

    // Delay to allow the dialog animation to complete
    await Future.delayed(const Duration(milliseconds: 1000));

    // Request ATT permission
    final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
    if (newStatus == TrackingStatus.notDetermined || newStatus == TrackingStatus.denied) {
      await showSettingsDialog(
        context,
        'To enhance your experience, please enable tracking in Settings > Privacy & Security > Tracking.',
      );
    }
  }

  // Retrieve the advertising identifier
  final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  if (uuid == '00000000-0000-0000-0000-000000000000') {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Unable to track your device")),
    );
  }
}

// Custom dialog to explain tracking
Future<void> showCustomTrackingDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Attention'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
}

// Settings dialog to guide the user to enable tracking
Future<void> showSettingsDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Settings Required'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () async {
            const url = 'app-settings:';
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              debugPrint('Could not launch $url');
            }
            Navigator.pop(context);
          },
          child: const Text('Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Not Now'),
        ),
      ],
    ),
  );
}
```

## Bugs & Feature Requests

If you encounter any issues or have feature requests, please [open an issue](https://github.com/jinosh05/unique_identifier_3/issues) on GitHub. Contributions through pull requests are also welcome!

## Additional Information

### Platform-Specific Behavior

- **Android (8.0 and above)**: `ANDROID_ID` is a unique, 64-bit hexadecimal string associated with each combination of app-signing key, user, and device. The value may change after a factory reset or if the app-signing key changes.
- **iOS**: The `identifierForVendor` (IDFV) is unique per vendor and can change if all apps from a vendor are uninstalled from a device and reinstalled.

For more details, see the official [Android 8.0 Behavior Changes](https://developer.android.com/about/versions/oreo/android-8.0-changes) documentation.

## License

This project is licensed under the [MIT License](LICENSE.md). 
