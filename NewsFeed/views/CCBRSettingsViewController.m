//
//  CCBRSettingsViewController.m
//  NewsFeed
//
//  Created by Phuc Nguyen on 30/12/2020.
//

#import "CCBRSettingsViewController.h"
#import "CCBRCommands.h"
#import "CCBRSettingsViewModel.h"

@interface CCBRSettingsViewController ()

@property(nonatomic, strong) CCBRSettingsViewModel*viewModel;
@property(nonatomic, assign) id<CCBRCommands> dispatcher;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CCBRSettingsViewController

- (instancetype)initWithViewModel:(CCBRSettingsViewModel*)viewModel dispatcher:(id<CCBRCommands>)dispatcher {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.dispatcher = dispatcher;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.viewModel title];
}

- (IBAction)didTapButton:(UIButton*)sender {
    if (sender == self.closeButton) {
        [self.dispatcher hideSettings];
    }
}

@end
