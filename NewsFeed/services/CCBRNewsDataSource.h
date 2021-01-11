//
//  CCBRArticleDataSource.h
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#ifndef CCBRArticleDataSource_h
#define CCBRArticleDataSource_h

@class CCBRNewsArticleModel;

@protocol CCBRArticleDataSource <NSObject>

@property (nonatomic, copy) void (^nextArticlesCallback)(NSUInteger startIndex, NSUInteger endIndex);
@property (nonatomic, copy) void (^nextArticlesErrorCallback)(NSError *error);

- (NSUInteger)articleCount;
- (NSError*)articleLoadingError;
- (CCBRNewsArticleModel*)articleBeforeArticle:(CCBRNewsArticleModel*)article;
- (CCBRNewsArticleModel*)articleAfterArticle:(CCBRNewsArticleModel*)article;
- (CCBRNewsArticleModel*)articleAtIndex:(NSInteger)index;
- (void)loadNextArticles;
- (BOOL)hasNextArticles;

@end

#endif /* CCBRArticleDataSource_h */
