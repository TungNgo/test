//
//  CCBRArticleCollectionView.m
//  NewsFeed
//
//  Created by tungngo on 10/14/20.
//

#import "CCBRNewsViewModel.h"

#import "CCBRNewsDataSource.h"
#import "CCBRNewsArticleModel.h"
#import "CCBRNewsCardViewModel.h"
#import "CCBRNewsDataStore.h"
#import "CCBREventLogger.h"

@interface CCBRNewsViewModel()
@property NSArray* loggedArticalIDs;
@property BOOL hasError;
@end

@implementation CCBRNewsViewModel


- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource {
    self = [super init];
    self.endIndex = 0;
    self.loggedArticalIDs = [[NSArray alloc] init];
    if (self) {
        self.dataSource = dataSource;
        
        __weak CCBRNewsViewModel *weakSelf = self;
        self.dataSource.nextArticlesCallback = ^(NSUInteger startIndex, NSUInteger endIndex) {
            weakSelf.endIndex = endIndex;
            weakSelf.hasError = weakSelf.dataSource.error != NULL;
            if (weakSelf.updateCallback) {
                weakSelf.updateCallback();
            }
        };
    }
    return self;
}

- (BOOL)collectionViewHidden {
    return self.dataSource.articleCount == 0;
}

- (BOOL)errorMessageLabelHidden {
    return !_hasError;
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

- (void)loadMore {
    CCBRNewsDataStore *_Nullable dataStore = self.dataSource;
    if (dataStore) {
        [dataStore loadNextArticles];
    }
}

- (void)logImpresstionEventForItemAtIndex:(NSUInteger)index {
    CCBRNewsArticleModel *article = [self.dataSource articleAtIndex:index];
    
    if ([self.loggedArticalIDs containsObject:article.newsFeedId]) {
        return;
    }
    
    [CCBREventLogger.shared logCardImpression:article.newsFeedId];
    
    self.loggedArticalIDs = [self.loggedArticalIDs arrayByAddingObject:article.newsFeedId];
}

- (void)logClickEventForItemAtIndex:(NSUInteger)index {
    CCBRNewsArticleModel *article = [self.dataSource articleAtIndex:index];
    if (article) {
        [CCBREventLogger.shared logCardClick:article.newsFeedId];
    }
}

@end
