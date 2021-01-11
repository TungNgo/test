//
//  CCBREventLogger.h
//  NewsFeed
//
//  Created by tungngo on 12/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCBREventLogger : NSObject

+ (instancetype)shared;

- (void)logCardImpression:(NSString *)cardId;
- (void)logCardClick:(NSString *)cardId;

- (void)createANewAppLogIfNeeded;
- (void)storeImpressedCardIDs;

@end

NS_ASSUME_NONNULL_END
