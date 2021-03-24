//
//  CCBRSettingsViewController.m
//  NewsFeed
//
//  Created by Keo Hoang Phuong on 24/03/2021.
//

#import "CCBRSettingsViewController.h"
#import "CCBRCommands.h"

@interface CCBRSettingsViewController ()

@property(nonatomic, strong) CCBRSettingsViewModel *viewModel;
@property(weak,nonatomic)IBOutlet UIButton*closeButton;

@end

@implementation CCBRSettingsViewController

- (instancetype)initWithViewModel:(CCBRSettingsViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (IBAction)didTapButton:(UIButton*)sender {
    if (sender == self.closeButton) {
        [self.dispatcher dismiss];
    }
}

@end
