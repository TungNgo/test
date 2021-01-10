//
//  Constants.h
//  NewsFeed
//
//  Created by Nghi Tran on 1/10/21.
//

#ifndef Constants_h
#define Constants_h

typedef enum : NSUInteger {
    NewsV2CardTypeBig = 1,
    NewsV2CardTypeMedium,
    NewsV2CardTypeSmall,
} NewsV2CardType;

FOUNDATION_EXPORT NSString *const CCBRNewsFeedDisplayType;
FOUNDATION_EXPORT NewsV2CardType const CCBRDefautlCardType;

#endif /* Constants_h */
