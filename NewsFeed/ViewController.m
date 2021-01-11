//
//  ViewController.m
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import "ViewController.h"

#import "CCBRNewsPageViewController.h"
#import "CCBRNewsQuickViewController.h"
#import "CCBRNewsPageViewModel.h"
#import "CCBRNewsDataStore.h"
#import "CCBRNewsViewController.h"
#import "CCBRNewsViewModel.h"
#import "CCBRCoordinator.h"

@interface ViewController ()

@property(nonatomic, strong) CCBRCoordinator *mainCoordinator;
@property(nonatomic, strong) CCBRNewsDataStore *articleDataStore;
@property(nonatomic, strong) CCBRNewsViewController *articleCollectionViewController;
@property(weak, nonatomic) IBOutlet UIView *articleCollectionContainerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainCoordinator = [[CCBRCoordinator alloc] initWithBaseViewController:self];
    
    self.articleDataStore = [[CCBRNewsDataStore alloc] init];
    [self.articleDataStore start];
    
    CCBRNewsViewModel *articleCollectionViewModel = [[CCBRNewsViewModel alloc] initWithDataSource:self.articleDataStore];
    self.articleCollectionViewController = [[CCBRNewsViewController alloc] initWithViewModel:articleCollectionViewModel dispatcher:self.mainCoordinator];
    self.mainCoordinator.articleCollectionViewModel = articleCollectionViewModel;
    
    UIView *articleCollectionView = self.articleCollectionViewController.view;
    [self addChildViewController:self.articleCollectionViewController];
    [self.articleCollectionContainerView addSubview:articleCollectionView];
    [self.articleCollectionViewController didMoveToParentViewController:self];
    
    articleCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [articleCollectionView.topAnchor constraintEqualToAnchor:_articleCollectionContainerView.topAnchor].active = YES;
    [articleCollectionView.leftAnchor constraintEqualToAnchor:_articleCollectionContainerView.leftAnchor].active = YES;
    [articleCollectionView.bottomAnchor constraintEqualToAnchor:_articleCollectionContainerView.bottomAnchor].active = YES;
    [articleCollectionView.rightAnchor constraintEqualToAnchor:_articleCollectionContainerView.rightAnchor].active = YES;
}

@end
