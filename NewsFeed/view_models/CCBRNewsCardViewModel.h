//
//  CCBRArticleItemViewModel.h
//  NewsFeed
//
//  Created by tungngo on 10/15/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CCBRNewsArticleModel;

@interface CCBRNewsCardViewModel : NSObject

- (instancetype)initWithModel:(CCBRNewsArticleModel *)model;

- (NSString *)cardId;
- (NSURL *)thumbnailURL;
- (UIImage *)favicon;
- (NSString *)sourceText;
- (NSString *)titleText;
- (NSString *)timeText;
- (NSString *)descriptionText;

@end

NS_ASSUME_NONNULL_END
