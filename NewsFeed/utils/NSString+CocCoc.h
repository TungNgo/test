#ifndef IOS_COCCOC_COMMON_NSSTRING_COCCOC_H_
#define IOS_COCCOC_COMMON_NSSTRING_COCCOC_H_

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <UIKit/UIKit.h>

@interface NSString (CocCoc)
-(BOOL)isEmpty;
- (NSString*)ccbr_stringByAddingQueryItems:(NSDictionary*)queryItems;

@end

#endif  // IOS_COCCOC_COMMON_NSSTRING_COCCOC_H_


// Check Commit 
