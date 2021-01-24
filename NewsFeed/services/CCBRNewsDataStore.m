//
//  CCBRArticleStore.m
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import "CCBRNewsDataStore.h"

#import "CCBRNewsArticleModel.h"
#import "CCBRNewsRestClient.h"
#import "CCBRNewsRestResponse.h"

NSUInteger const pageSize = 30;

@interface CCBRNewsDataStore ()

@property(nonatomic, strong) NSMutableArray *articles;
@property(nonatomic, strong) CCBRNewsRestClient*newsRestClient;
@property(nonatomic, assign) NSUInteger page;
@property(nonatomic, assign) BOOL loading;

@end

@implementation CCBRNewsDataStore

- (void)start {
    self.articles = [[NSMutableArray alloc] init];
    self.newsRestClient = [[CCBRNewsRestClient alloc] init];
    self.page = 0;
    
    [self loadNextArticles];
}

- (void)loadMoreArticles {
    [self loadNextArticles];
}

- (void)loadNextArticles {
    if (self.loading) {
        return;
    }
    
    self.loading = YES;
    [self.newsRestClient loadArticlesWithSessionId:@"3C9BBC6A-1C55-4527-B75D-434EEA10072D" page:self.page size:pageSize newSession:YES block:^(NSData * _Nonnull data, NSError * _Nonnull error) {
        self.loading = NO;
        
        if (error) {
            // TODO: Handle error
            if (self.errorCallback) {
                self.errorCallback(error);
            }
            
        } else {
            CCBRNewsRestResponse *response = [[CCBRNewsRestResponse alloc] initWithData:data error:&error];
            if (error) {
                // TODO: Handle error
                if (self.errorCallback) {
                    self.errorCallback(error);
                }
                
            } else {
                self.page = response.nextPage.integerValue;
                NSUInteger startIndex = self.articles.count;
                NSUInteger endIndex = startIndex + response.news.count - 1;
                [self.articles addObjectsFromArray:response.news];
                if (self.nextArticlesCallback) {
                    self.nextArticlesCallback(startIndex, endIndex);
                }
            }
        }
    }];
}

- (NSUInteger)articleCount {
    return self.articles.count;
}

- (CCBRNewsArticleModel *)articleBeforeArticle:(CCBRNewsArticleModel *)article {
    NSUInteger index = [self.articles indexOfObject:article];
    if (index == 0) {
        return nil;
    } else {
        return self.articles[index-1];
    }
}

- (CCBRNewsArticleModel *)articleAfterArticle:(CCBRNewsArticleModel *)article {
    NSUInteger index = [self.articles indexOfObject:article];
    
    if (index >= self.articles.count - 1) {
        return nil;
    } else {
        return self.articles[index+1];
    }
}

- (CCBRNewsArticleModel *)articleAtIndex:(NSInteger)index {
    if (index < 0 || index > self.articles.count - 1) {
        return nil;
    }
    
    return self.articles[index];
}

@end
