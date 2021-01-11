//
//  CCBRSettingsViewController.m
//  NewsFeed
//
//  Created by Nghi Tran on 1/10/21.
//

#import "CCBRSettingsViewController.h"
#import "Constants.h"
#import "CCBRSettingsViewModel.h"
#import "CCBRCommands.h"

@interface CCBRSettingsViewController ()

@property(nonatomic, strong) CCBRSettingsViewModel*viewModel;
@property(nonatomic, assign) id<CCBRCommands> dispatcher;

@property (weak, nonatomic) IBOutlet UISegmentedControl *displayTypeSegment;

@property (nonatomic, assign) NewsV2CardType cardType;

@end

@implementation CCBRSettingsViewController

- (instancetype)initWithViewModel:(CCBRSettingsViewModel*)viewModel
                       dispatcher:(id<CCBRCommands>)dispatcher{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.dispatcher = dispatcher;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUI];
}

- (void)updateUI {
    self.displayTypeSegment.selectedSegmentIndex = self.viewModel.currentSegmentIndex;
}

// MARK: - Event Handlers
- (IBAction)dismissButtonTapped:(id)sender {
    [self.dispatcher hideSettings];
}

- (IBAction)displayTypeSegmentValueChanged:(id)sender {
    NewsV2CardType newCardType = [self.viewModel cardTypeWithIndex:self.displayTypeSegment.selectedSegmentIndex];
    [self.viewModel storeCardType:newCardType];
}

@end
