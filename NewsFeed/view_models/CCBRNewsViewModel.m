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

@interface CCBRNewsViewModel()

@property(nonatomic, strong) NSError* error;

@end

@implementation CCBRNewsViewModel

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        
        __weak CCBRNewsViewModel *weakSelf = self;
        self.dataSource.nextArticlesCallback = ^(NSUInteger startIndex, NSUInteger endIndex, NSError *error) {
            self.error = error;
            if (weakSelf.updateCallback) {
                weakSelf.updateCallback(startIndex, endIndex);
            }
        };
    }
    return self;
}

- (void)loadMore {
    [self.dataSource loadMoreArticles];
}

- (BOOL)collectionViewHidden {
    return self.dataSource.articleCount == 0;
}

- (NSString*)errorMessageLabelText {
    return self.error.localizedDescription;
}

- (BOOL)errorMessageLabelHidden {
    return self.error == nil ? YES : NO;
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

@end
