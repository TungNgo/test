//
//  CCBRArticleStore.h
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import <Foundation/Foundation.h>

#import "CCBRNewsDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@class CCBRNewsArticleModel;

@interface CCBRNewsDataStore : NSObject<CCBRArticleDataSource>

@property (nonatomic, copy) void (^nextArticlesCallback)(NSUInteger startIndex, NSUInteger endIndex);
@property (nonatomic, copy) void (^errorCallback)(NSError *error);

- (void)start;

@end

NS_ASSUME_NONNULL_END
