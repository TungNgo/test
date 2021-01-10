//
//  CCBRSettingsViewController.h
//  NewsFeed
//
//  Created by Nghi Tran on 1/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CCBRSettingsViewModel;
@protocol CCBRCommands;

@interface CCBRSettingsViewController : UIViewController

- (instancetype)initWithViewModel:(CCBRSettingsViewModel*)viewModel
                       dispatcher:(id<CCBRCommands>)dispatcher;


@end

NS_ASSUME_NONNULL_END
