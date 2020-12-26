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

@implementation CCBRNewsViewModel

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        
        __weak CCBRNewsViewModel *weakSelf = self;
        self.dataSource.nextArticlesCallback = ^(NSUInteger startIndex, NSUInteger endIndex) {
            weakSelf.hasError = NO;
            if (weakSelf.nextArticlesCallback) {
                weakSelf.nextArticlesCallback(startIndex, endIndex);
            }
        };
        self.dataSource.nextArticlesErrorCallback = ^(NSString* errorMessage) {
            weakSelf.hasError = YES;
            if (weakSelf.errorCallback) {
                weakSelf.errorCallback(errorMessage);
            }
        };
        self.dataSource.updateLoading = ^(BOOL isLoading) {
            weakSelf.isLoading = isLoading;
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
    return !self.hasError;
}

- (BOOL)indicatorViewLoading {
    return self.isLoading;
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
    [self.dataSource loadMoreArticles];
}

@end
