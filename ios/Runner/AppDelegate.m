#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"AIzaSyDtGnCc4XOzVt_qXij2yvx-Wr92uuLvS5I"];
    [GeneratedPluginRegistrant registerWithRegistry:self];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
