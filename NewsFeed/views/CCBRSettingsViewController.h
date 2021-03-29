//
//  CCBRSettingsViewController.h
//  NewsFeed
//
//  Created by Keo Hoang Phuong on 24/03/2021.
//

#import <UIKit/UIKit.h>
#import "CCBRSettingsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CCBRSettingsViewModel;
@protocol CCBRCommands;

@interface CCBRSettingsViewController : UIViewController

@property(nonatomic, assign) id<CCBRCommands> dispatcher;

- (instancetype)initWithViewModel:(CCBRSettingsViewModel*)viewModel;

@end

NS_ASSUME_NONNULL_END
