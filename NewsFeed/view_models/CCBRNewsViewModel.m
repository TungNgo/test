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
            if (weakSelf.updateCallback) {
                weakSelf.updateCallback();
            }
        };
        self.dataSource.errorCallBack = ^(NSError *error) {
            if (weakSelf.updateErrorCallback) {
                weakSelf.updateErrorCallback(error);
            }
        };
    }
    return self;
}

- (void)loadMoreArticlesAtIndex:(NSUInteger)index {
    if (index == [self itemCount] - 1) {
        [self.dataSource loadNextArticles];
    }
}

- (BOOL)collectionViewHidden {
    return self.dataSource.articleCount == 0;
}

- (BOOL)collectionViewHidden:(NSError *)error {
    if (error) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)errorMessageLabelHidden {
    return YES;
}

- (BOOL)errorMessageLabelHidden:(NSError *)error {
    if (error) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)errorMessageLabelText:(NSError *)error {
    return error.description;
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

- (void)goToSettingScreen {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]  options:@{} completionHandler:nil];
}

@end
