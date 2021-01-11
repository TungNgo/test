//
//  CCBRArticleCollectionViewController.m
//  NewsFeed
//
//  Created by tungngo on 10/15/20.
//

#import "CCBRNewsViewController.h"
#import "CCBRNewsCardViewModel.h"
#import "CCBRNewsViewModel.h"
#import "CCBRNewsBigCardView.h"
#import "CCBRNewsMediumCardView.h"
#import "CCBRNewsSmallCardView.h"
#import "CCBRCommands.h"
#import "Constants.h"
#import "CCBRNewsDataStore.h"
#import "CCBRNewsArticleModel.h"
#import "CCBREventLogger.h"

@interface CCBRNewsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) CCBRNewsViewModel*viewModel;
@property(nonatomic, assign) id<CCBRCommands> dispatcher;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (weak, nonatomic) IBOutlet UIView *collectionContainerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@end

@implementation CCBRNewsViewController

static NSString * const kCCBRNewsBigCardView = @"CCBRNewsBigCardView";
static NSString * const kCCBRNewsMediumCardView = @"CCBRNewsMediumCardView";
static NSString * const kCCBRNewsSmallCardView = @"CCBRNewsSmallCardView";

- (instancetype)initWithViewModel:(CCBRNewsViewModel*)viewModel
                       dispatcher:(id<CCBRCommands>)dispatcher{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.dispatcher = dispatcher;
        
        __weak CCBRNewsViewController *weakSelf = self;
        self.viewModel.updateCallback = ^(NSUInteger startIndex, NSUInteger endIndex){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf addMoreArticlesFromIndex:startIndex toIndex:endIndex];
            });
        };
        
        self.viewModel.errorCallback = ^(NSError * error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf updateUI];
            });
        };
        
        self.viewModel.displayModeChanged = ^(NewsV2CardType cardType){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf updateUIWithCurrentDisplayMode];
            });
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorMessageLabel.text = @"Opps, something went wrong while loading the articles. Please check back in a bit.";
    self.errorMessageLabel.textColor = [UIColor systemRedColor];
    self.errorMessageLabel.numberOfLines = 0;
    self.errorMessageLabel.hidden = self.viewModel.errorMessageLabelHidden;

    if (self.cardType == NewsV2CardTypeMedium || self.cardType == NewsV2CardTypeSmall) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
        layout.minimumLineSpacing = 0;
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:kCCBRNewsBigCardView
                                                    bundle:nil]
          forCellWithReuseIdentifier:kCCBRNewsBigCardView];
    [self.collectionView registerNib:[UINib nibWithNibName:kCCBRNewsMediumCardView
                                                    bundle:nil]
          forCellWithReuseIdentifier:kCCBRNewsMediumCardView];
    [self.collectionView registerNib:[UINib nibWithNibName:kCCBRNewsSmallCardView
                                                    bundle:nil]
          forCellWithReuseIdentifier:kCCBRNewsSmallCardView];
    
    [self updateUI];
}

- (void)updateUI {
    self.collectionView.hidden = self.viewModel.collectionViewHidden;
    self.errorMessageLabel.hidden = self.viewModel.errorMessageLabelHidden;
    [self.collectionView reloadData];
}

- (void)addMoreArticlesFromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex  {
    self.collectionView.hidden = self.viewModel.collectionViewHidden;
    self.errorMessageLabel.hidden = self.viewModel.errorMessageLabelHidden;
    
    if (startIndex > self.viewModel.itemCount - 1) {
        return;
    }
    
    [self.collectionView performBatchUpdates:^{
        NSMutableArray* newIndexs = [[NSMutableArray alloc] init];
        for (NSUInteger newIndex = startIndex; newIndex <= endIndex; newIndex++) {
            if (newIndex > self.viewModel.itemCount - 1 ) {
                break;
            }
            [newIndexs addObject: [NSIndexPath indexPathForItem:newIndex inSection:0]];
        }
        [self.collectionView insertItemsAtIndexPaths:newIndexs];
    } completion:nil];
}

- (void)updateUIWithCurrentDisplayMode {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    if (self.cardType == NewsV2CardTypeMedium || self.cardType == NewsV2CardTypeSmall) {
        layout.minimumLineSpacing = 0;
    }
    else {
        layout.minimumLineSpacing = 10;
    }
    
    [self.collectionView reloadData];
}

- (NewsV2CardType)cardType {
    return self.viewModel.displayMode;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    CCBRNewsCardViewModel *itemViewModel = [self.viewModel itemViewModelAtIndex:indexPath.row];
    if (self.cardType == NewsV2CardTypeSmall) {
        CCBRNewsSmallCardView *smallCardView = (CCBRNewsSmallCardView *)[collectionView dequeueReusableCellWithReuseIdentifier:kCCBRNewsSmallCardView forIndexPath:indexPath];
        smallCardView.viewModel = itemViewModel;
        cell = smallCardView;
    } else if (self.cardType == NewsV2CardTypeMedium) {
        CCBRNewsMediumCardView *mediumCardView = (CCBRNewsMediumCardView *)[collectionView dequeueReusableCellWithReuseIdentifier:kCCBRNewsMediumCardView forIndexPath:indexPath];
        mediumCardView.viewModel = itemViewModel;
        cell = mediumCardView;
    } else if (self.cardType == NewsV2CardTypeBig) {
        CCBRNewsBigCardView *bigCardView = (CCBRNewsBigCardView *)[collectionView dequeueReusableCellWithReuseIdentifier:kCCBRNewsBigCardView forIndexPath:indexPath];
        bigCardView.viewModel = itemViewModel;
        cell = bigCardView;
    }
    
    if (itemViewModel) {
        [self.viewModel didLoadArticle:itemViewModel.model atIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cardID = [self.viewModel.dataSource articleAtIndex:indexPath.row].newsFeedId;
    [[CCBREventLogger shared] logCardImpression:cardID];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.dispatcher showNewsWithDataSource:self.viewModel.dataSource
                                 startIndex:indexPath.row];
    NSString* cardID = [self.viewModel.dataSource articleAtIndex:indexPath.row].newsFeedId;
    [[CCBREventLogger shared] logCardClick:cardID];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = CGRectGetWidth(UIScreen.mainScreen.bounds);
    CGFloat itemWidth = screenWidth - 2 * 8;
    CGFloat itemHeight = 114;
    
    if (self.cardType == NewsV2CardTypeBig) {
        itemHeight = 324;
    } else if (self.cardType == NewsV2CardTypeMedium) {
        itemHeight = 168;
    } else {
        itemHeight = 114;
    }
    
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark - Event Handlers

- (IBAction)didTapButton:(UIButton *)sender {
    if (sender == self.settingsButton) {
        [self.dispatcher showSettings];
    }
}

@end
