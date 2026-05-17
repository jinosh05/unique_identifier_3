## 0.1.0

* Added support for **Web**, **macOS**, **Linux**, and **Windows** platforms
* **Web**: Retrieves UUID from `localStorage`, with browser fingerprint and random generation fallbacks
* **macOS**: Retrieves `IOPlatformUUID` via IOKit (uses `kIOMainPortDefault` on macOS 12+, falls back to `kIOMasterPortDefault` for macOS 11)
* **Linux**: Reads `/etc/machine-id`
* **Windows**: Reads `MachineGuid` from registry `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography`
* Fixed iOS implementation to use `UIDevice.identifierForVendor` instead of custom UUID
* Added Swift Package Manager support via `Package.swift`
* Updated `flutter_lints` to `^6.0.0`

## 0.0.1

* Initial release with Android and iOS support
