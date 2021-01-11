//
//  CCBRSettingsViewModel.h
//  NewsFeed
//
//  Created by Nghi Tran on 1/10/21.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBRSettingsViewModel : NSObject

+ (NewsV2CardType)storedCardType;

- (NewsV2CardType)currentCardType;
- (NSUInteger)currentSegmentIndex;
- (void)storeCardType:(NewsV2CardType)cardType;
- (NewsV2CardType)cardTypeWithIndex:(NSUInteger)index;
- (NSUInteger)indexWithCardType:(NewsV2CardType)cardType;

@end

NS_ASSUME_NONNULL_END
