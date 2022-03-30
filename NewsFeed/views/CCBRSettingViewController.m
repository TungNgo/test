//
//  CCBRSettingViewController.m
//  NewsFeed
//
//  Created by Hoang Tran on 29/03/2022.
//

#import "CCBRSettingViewController.h"

@interface CCBRSettingViewController ()

@end

@implementation CCBRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationView];
    self.title = @"Settings";
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)setupNavigationView {
    UIBarButtonItem * closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismissSelf)];
    self.navigationItem.leftBarButtonItem = closeButton;
}

- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
