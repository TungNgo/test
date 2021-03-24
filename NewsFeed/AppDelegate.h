//
//  AppDelegate.h
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import <UIKit/UIKit.h>

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

- (UIViewController*) topMostController;

@end

