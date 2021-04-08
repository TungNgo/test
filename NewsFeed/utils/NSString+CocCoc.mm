//
//  NSString+CocCoc.mm
//
//  Copyright © 2016 Coc Coc. All rights reserved.
//

#import "NSString+CocCoc.h"

#import <UIKit/UIKit.h>

@implementation NSString (CocCoc)
-(BOOL)isEmpty{
    return [self isEqualToString:@""];;
}

- (NSString*)ccbr_stringByAddingQueryItems:(NSDictionary*)keyValuePairs {
  NSURLComponents* components = [NSURLComponents componentsWithString:self];
  NSMutableArray* newQueryItems =
      [NSMutableArray arrayWithArray:components.queryItems];

  for (NSString* name in keyValuePairs) {
    BOOL existed = NO;

    for (NSURLQueryItem* queryItem in newQueryItems) {
      if ([queryItem.name isEqualToString:name]) {
        existed = YES;
        break;
      }
    }

    if (!existed) {
      NSString* value = [keyValuePairs objectForKey:name];
      NSURLQueryItem* newQueryItem =
          [NSURLQueryItem queryItemWithName:name value:value];
      [newQueryItems addObject:newQueryItem];
    }
  }

  components.queryItems = newQueryItems;
    
  return components.string;
}

@end
