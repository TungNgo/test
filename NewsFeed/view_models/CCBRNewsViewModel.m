//
//  CCBRArticleCollectionView.m
//  NewsFeed
//
//  Created by tungngo on 10/14/20.
//

#import "CCBRNewsViewModel.h"
#import "CCBRNewsDataSource.h"
#import "CCBRNewsDataStore.h"
#import "CCBRNewsArticleModel.h"
#import "CCBRNewsCardViewModel.h"
#import "CCBRSettingsViewModel.h"

@interface CCBRNewsViewModel()

@property(nonatomic, assign) NewsV2CardType cardType;

@end

@implementation CCBRNewsViewModel

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        
        __weak CCBRNewsViewModel *weakSelf = self;
        self.dataSource.nextArticlesCallback = ^(NSUInteger startIndex, NSUInteger endIndex) {
            if (weakSelf.updateCallback) {
                weakSelf.updateCallback(startIndex, endIndex);
            }
        };
        
        self.dataSource.nextArticlesErrorCallback = ^(NSError * _Nonnull error) {
            if (weakSelf.errorCallback) {
                weakSelf.errorCallback(error);
            }
        };
        
        self.cardType = CCBRSettingsViewModel.storedCardType;
    }
    return self;
}

- (BOOL)collectionViewHidden {
    return self.dataSource.articleCount == 0;
}

- (BOOL)errorMessageLabelHidden {
    BOOL hidden = self.dataSource.articleLoadingError == nil;
    return hidden;
}

- (NSUInteger)itemCount {
    return self.dataSource.articleCount;
}

- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index {
    CCBRNewsArticleModel *article = [self.dataSource articleAtIndex:index];
    if (article) {
        return [[CCBRNewsCardViewModel alloc] initWithModel:article];
    }
    return nil;
}

// MARK: - Handle UI reactions
- (void)didLoadArticle:(CCBRNewsArticleModel *)article atIndex:(NSUInteger)index {
    //Will try to load more articles if the last item on UI is dislayed and there are more items
    //This condition can be optimized base on the current UI states if needed
    if (index >= [self itemCount] - 1 && [self.dataSource hasNextArticles]) {
        [self.dataSource loadNextArticles];
    }
}

- (NewsV2CardType)displayMode {
    return _cardType;
}

- (void)setDisplayMode:(NewsV2CardType)displayMode {
    if (self.cardType != displayMode) {
        self.cardType = displayMode;
        
        if (self.displayModeChanged) {
            self.displayModeChanged(displayMode);
        }
    }
}

@end
