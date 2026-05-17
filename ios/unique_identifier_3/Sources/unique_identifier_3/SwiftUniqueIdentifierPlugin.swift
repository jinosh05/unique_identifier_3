import Flutter
import UIKit

public class SwiftUniqueIdentifierPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "unique_identifier", binaryMessenger: registrar.messenger())
    let instance = SwiftUniqueIdentifierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getUniqueIdentifier" {
      let identifierForVendor = UIDevice.current.identifierForVendor?.uuidString
      result(identifierForVendor)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
