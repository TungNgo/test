//
//  CCBRArticleCollectionView.h
//  NewsFeed
//
//  Created by tungngo on 10/14/20.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CCBRArticleDataSource;
@class CCBRNewsCardViewModel;
@class CCBRNewsArticleModel;

@interface CCBRNewsViewModel : NSObject

@property(nonatomic, weak) id<CCBRArticleDataSource> dataSource;
@property(nonatomic, copy) void (^updateCallback)(NSUInteger, NSUInteger);
@property(nonatomic, copy) void (^errorCallback)(NSError * _Nonnull error);
@property(nonatomic, copy) void (^displayModeChanged)(NewsV2CardType cardType);
@property(nonatomic, assign) NewsV2CardType displayMode;

- (instancetype)initWithDataSource:(id<CCBRArticleDataSource>)dataSource;

- (BOOL)collectionViewHidden;
- (BOOL)errorMessageLabelHidden;
- (NSUInteger)itemCount;
- (CCBRNewsCardViewModel *)itemViewModelAtIndex:(NSUInteger)index;
- (void)didLoadArticle:(CCBRNewsArticleModel *)article atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
