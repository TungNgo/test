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
#import "NSString+CocCoc.h"


@interface CCBRNewsViewModel ()

@property(nonatomic, strong) NSString *errorRequeestDescription;

@end



@implementation CCBRNewsViewModel

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        
        __weak CCBRNewsViewModel *weakSelf = self;
        self.dataSource.nextArticlesCallback = ^(NSUInteger startIndex, NSUInteger endIndex) {
            if (weakSelf.updateCallback) {
                weakSelf.errorRequeestDescription = @"" ;
                weakSelf.updateCallback();
            }
        };
        
        self.dataSource.errorCallBack = ^(NSString *errorDescription) {
            if (weakSelf.updateCallback) {
                weakSelf.errorRequeestDescription = errorDescription ;
                weakSelf.updateCallback();
            }
        };
    }
    return self;
}

- (BOOL)collectionViewHidden {
    return self.dataSource.articleCount == 0;
}
- (NSString*)errorMessageDescription{
    return self.errorRequeestDescription;
}

- (BOOL)errorMessageLabelHidden {
    return [self.errorRequeestDescription isEmpty];
}

- (NSUInteger)itemCount {
    return self.dataSource.articleCount;
}

- (BOOL)shouldReloadGridData{
    return [self.errorRequeestDescription isEmpty];
}

- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index {
    CCBRNewsArticleModel *article = [self.dataSource articleAtIndex:index];
    if (article) {
        return [[CCBRNewsCardViewModel alloc] initWithModel:article];
    }
    return nil;
}

- (void)willDisplayItemAtIndex:(NSUInteger)index{
    if(index == ([self itemCount] - 1))
    {
        [self.dataSource loadNextArticles] ;
    }
}



@end
