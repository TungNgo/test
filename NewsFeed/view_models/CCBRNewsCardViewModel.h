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

@property(nonatomic, strong, readonly) CCBRNewsArticleModel *model;

- (instancetype)initWithModel:(CCBRNewsArticleModel *)model;

- (NSURL *)thumbnailURL;
- (UIImage *)favicon;
- (NSString *)sourceText;
- (NSString *)titleText;
- (NSString *)timeText;
- (NSString *)descriptionText;

@end

NS_ASSUME_NONNULL_END
