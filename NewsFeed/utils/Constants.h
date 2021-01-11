//
//  Constants.h
//  NewsFeed
//
//  Created by Nghi Tran on 1/10/21.
//

#ifndef Constants_h
#define Constants_h

// MARK: - Custom Data Type
typedef enum : NSUInteger {
    NewsV2CardTypeBig = 1,
    NewsV2CardTypeMedium,
    NewsV2CardTypeSmall,
} NewsV2CardType;

// MARK: - Constant Values
FOUNDATION_EXPORT NSString      *const CCBRNewsFeedDisplayType;
FOUNDATION_EXPORT NewsV2CardType const CCBRDefautlCardType;
FOUNDATION_EXPORT NSString      *const CCBRConsoleLogFileName;
FOUNDATION_EXPORT NSString      *const CCBROldConsoleLogFileName;
FOUNDATION_EXPORT NSUInteger     const CCBRConsoleLogFileSize;
FOUNDATION_EXPORT NSString      *const CCBRImpressedCardIDsKey;

// MARK: - Utility Marcos
#define PathForDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define PathForFileName(v) ([PathForDir stringByAppendingPathComponent:v])

#endif /* Constants_h */
