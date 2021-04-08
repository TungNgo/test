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
@property(nonatomic, copy) void (^updateCallback)();

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource;

- (BOOL)collectionViewHidden;
- (BOOL)errorMessageLabelHidden;
- (NSString*)errorMessageDescription;
- (BOOL)shouldReloadGridData;;



- (NSUInteger)itemCount;
- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index;
- (void)willDisplayItemAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
