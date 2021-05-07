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
@property(nonatomic, copy) void (^updateErrorCallback)(NSError* error);

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource;

- (BOOL)collectionViewHidden;
- (BOOL)collectionViewHidden:(NSError *)error;
- (BOOL)errorMessageLabelHidden;
- (BOOL)errorMessageLabelHidden:(NSError *)error;
- (NSString *)errorMessageLabelText:(NSError *)error;
- (NSUInteger)itemCount;
- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index;
- (void)loadMoreArticlesAtIndex:(NSUInteger)index;
- (void)goToSettingScreen;

@end

NS_ASSUME_NONNULL_END
