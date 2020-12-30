//
//  CCBRSettingsViewController.h
//  NewsFeed
//
//  Created by Thanh Pham on 12/27/20.
//

#import <UIKit/UIKit.h>

@class CCBRSettingsViewModel;
@protocol CCBRCommands;

NS_ASSUME_NONNULL_BEGIN

@interface CCBRSettingsViewController : UIViewController

- (instancetype)initWithViewModel:(CCBRSettingsViewModel*)viewModel;

@property(nonatomic, strong) CCBRSettingsViewModel*viewModel;
@property(nonatomic, assign) id<CCBRCommands> dispatcher;

@end

NS_ASSUME_NONNULL_END
