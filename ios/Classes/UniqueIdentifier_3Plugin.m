#import "UniqueIdentifier_3Plugin.h"
#import <UIKit/UIKit.h>

@implementation UniqueIdentifier_3Plugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"unique_identifier"
            binaryMessenger:[registrar messenger]];
  UniqueIdentifier_3Plugin* instance = [[UniqueIdentifier_3Plugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getUniqueIdentifier" isEqualToString:call.method]) {
    NSString *uniqueID = [[NSUserDefaults standardUserDefaults] stringForKey:@"custom_unique_identifier"];
    if (!uniqueID) {
      uniqueID = [[NSUUID UUID] UUIDString];
      [[NSUserDefaults standardUserDefaults] setObject:uniqueID forKey:@"custom_unique_identifier"];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
    result(uniqueID);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end