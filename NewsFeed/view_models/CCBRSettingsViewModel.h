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
- (void)storeCardType:(NewsV2CardType)cardType;
- (NewsV2CardType)cardTypeWithIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
