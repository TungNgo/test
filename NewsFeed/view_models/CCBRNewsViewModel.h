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
@property(nonatomic, copy) void (^errorCallback)(NSError* error);
@property(nonatomic, assign) BOOL isHiddenErrorMessageLabel;

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource;

- (BOOL)collectionViewHidden;
- (BOOL)errorMessageLabelHidden;
- (NSUInteger)itemCount;
- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index;
- (void)loadMore;
- (void)logCardClickEventWithIndex:(NSUInteger)index;
- (void)logCardImpressionWithIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
