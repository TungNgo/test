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
#import "CCBREventLogger.h"
#import "AppDelegate.h"

@implementation CCBRNewsViewModel

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.isHiddenErrorMessageLabel = YES;
        
        __weak CCBRNewsViewModel *weakSelf = self;
        self.dataSource.nextArticlesCallback = ^(NSUInteger startIndex, NSUInteger endIndex) {
            if (weakSelf.updateCallback) {
                weakSelf.isHiddenErrorMessageLabel = YES;
                weakSelf.updateCallback();
            }
        };
        self.dataSource.errorCallback = ^(NSError *error) {
            if (weakSelf.errorCallback) {
                weakSelf.isHiddenErrorMessageLabel = NO;
                weakSelf.errorCallback(error);
            }
        };
    }
    return self;
}

- (BOOL)collectionViewHidden {
    return self.dataSource.articleCount == 0;
}

- (BOOL)errorMessageLabelHidden {
    if (self.collectionViewHidden && !self.isHiddenErrorMessageLabel) {
        return NO;
    }
    return YES;
}

- (NSString*)showErrorMessage:(NSError *)error {
    NSString* message = @"API errors";
    if (![error.localizedDescription isEqualToString:@""]) {
        message = error.localizedDescription;
    }
    if (self.errorMessageLabelHidden) {
        [APPDELEGATE showMessage:message];
        return @"";
    }
    return message;
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
    [self.dataSource loadMore];
}

#pragma mark - Log
- (void)logCardClickEventWithIndex:(NSUInteger)index {
    CCBRNewsArticleModel *article = [self.dataSource articleAtIndex:index];
    if (![article.newsFeedId isEqualToString:@""]) {
        [[CCBREventLogger shared] logCardClick:article.newsFeedId];
    }
}

- (void)logCardImpressionWithIndex:(NSUInteger)index {
    CCBRNewsArticleModel *article = [self.dataSource articleAtIndex:index];
    if (![article.newsFeedId isEqualToString:@""]) {
        [[CCBREventLogger shared] logCardImpression:article.newsFeedId];
    }
}

@end
