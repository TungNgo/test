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
@property(nonatomic, copy) void (^updateCallback)(NSUInteger startIndex, NSUInteger endIndex);

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource;

- (void)loadMore;
- (BOOL)collectionViewHidden;
- (BOOL)errorMessageLabelHidden;
- (NSString*)errorMessageLabelText;
- (NSUInteger)itemCount;
- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
