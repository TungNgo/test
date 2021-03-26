//
//  CCBRArticlePreviewViewModel.h
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CCBRNewsArticleModel;

@interface CCBRNewsQuickViewModel : NSObject

@property(nonatomic, strong, readonly) CCBRNewsArticleModel*model;
@property (nonatomic, assign) BOOL isLoggedImpression;

- (instancetype)initWithModel:(CCBRNewsArticleModel*)model;

- (NSString*)title;
- (NSString*)url;
- (NSString*)domain;
- (UIImage*)favicon;

@end

NS_ASSUME_NONNULL_END
