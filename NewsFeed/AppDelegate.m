//
//  AppDelegate.m
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "CCBREventLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Redirect NSLog output to ".../Documents/console.log" file so that users can retrieve it.
   
    /**
     FOR CODE REVIEW:
     Comment this #ifndef macro to redirect the console log to write to ".../Documents/console.log" file.
     */
    
//#if TARGET_IPHONE_SIMULATOR == 0
#ifndef DEBUG
    NSString *logPath = PathForFileName(CCBRConsoleLogFileName);
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stderr);
#endif
//#endif
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[CCBREventLogger shared] createANewAppLogIfNeeded];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[CCBREventLogger shared] storeImpressedCardIDs];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[CCBREventLogger shared] storeImpressedCardIDs];
}

@end
