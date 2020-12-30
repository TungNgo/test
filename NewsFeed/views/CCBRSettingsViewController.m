//
//  CCBRSettingsViewController.m
//  NewsFeed
//
//  Created by Thanh Pham on 12/27/20.
//

#import "CCBRSettingsViewController.h"

@interface CCBRSettingsViewController ()

@end

@implementation CCBRSettingsViewController

- (instancetype)initWithViewModel:(CCBRSettingsViewModel*)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
