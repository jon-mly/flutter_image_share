#import "ImageSharePlugin.h"

@implementation ImageSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"image_share"
            binaryMessenger:[registrar messenger]];
  ImageSharePlugin* instance = [[ImageSharePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"shareFile" isEqualToString:call.method]) {
      UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
      [self shareFile:[call arguments] withController:controller];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)shareFile:(id)sharedItems withController:(UIViewController *)controller {
    NSMutableString *filePath = [NSMutableString stringWithString:sharedItems];
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagePath = [docsPath stringByAppendingPathComponent:filePath];
    NSURL *imageUrl = [NSURL fileURLWithPath:imagePath];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *shareImage = [UIImage imageWithData:imageData];

    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[ shareImage ]
                                      applicationActivities:nil];
    [controller presentViewController:activityViewController animated:YES completion:nil];
}

@end
