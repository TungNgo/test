//
//  CCBRSettingsViewModel.m
//  NewsFeed
//
//  Created by Nghi Tran on 1/10/21.
//

#import "CCBRSettingsViewModel.h"

@interface CCBRSettingsViewModel ()

@property(nonatomic, assign) NewsV2CardType cardType;

@end

@implementation CCBRSettingsViewModel

+ (NewsV2CardType)storedCardType {
    NewsV2CardType cardType = CCBRDefautlCardType;
    NSUInteger typeNumber = [[NSUserDefaults standardUserDefaults] integerForKey:CCBRNewsFeedDisplayType];
    switch (typeNumber) {
        case NewsV2CardTypeBig:
        case NewsV2CardTypeMedium:
        case NewsV2CardTypeSmall:
            cardType = typeNumber;
            break;
        default:
            break;
    }
    return cardType;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cardType = [CCBRSettingsViewModel storedCardType];
    }
    return self;
}

- (NewsV2CardType)currentCardType {
    return _cardType;
}

- (void)storeCardType:(NewsV2CardType)cardType {
    self.cardType = cardType;
    [[NSUserDefaults standardUserDefaults] setInteger:self.cardType forKey:CCBRNewsFeedDisplayType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NewsV2CardType)cardTypeWithIndex:(NSUInteger)index {
    NewsV2CardType cardType = CCBRDefautlCardType;
    switch (index) {
        case 0:
            cardType = NewsV2CardTypeBig;
            break;
        case 1:
            cardType = NewsV2CardTypeMedium;
            break;
        case 2:
            cardType = NewsV2CardTypeSmall;
            break;
        default:
            break;
    }
    return cardType;
}

@end
