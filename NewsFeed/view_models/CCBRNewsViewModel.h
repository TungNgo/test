//
//  CCBRArticleCollectionView.h
//  NewsFeed
//
//  Created by tungngo on 10/14/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CCBRArticleDataSource;
@class CCBRNewsCardViewModel;

@interface CCBRNewsViewModel : NSObject

@property(nonatomic, weak) id<CCBRArticleDataSource> dataSource;
@property(nonatomic, copy) void (^updateCallback)(void);
@property(nonatomic, copy) void (^nextArticlesCallback)(NSUInteger startIndex, NSUInteger endIndex);
@property(nonatomic, copy) void (^errorCallback)(NSString *errorMessage);
@property(nonatomic, assign) BOOL hasError;
@property(nonatomic, assign) BOOL isLoading;

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource;

- (BOOL)collectionViewHidden;
- (BOOL)errorMessageLabelHidden;
- (BOOL)indicatorViewLoading;
- (NSUInteger)itemCount;
- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index;
- (void)loadMore;

@end

NS_ASSUME_NONNULL_END
