//
//  CCBREventLogger.m
//  NewsFeed
//
//  Created by tungngo on 12/3/20.
//

#import "CCBREventLogger.h"

@implementation CCBREventLogger

+ (instancetype)shared {
    static CCBREventLogger *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CCBREventLogger alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"cardIdsSet"];
        self.cardIdsSet = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (!self.cardIdsSet) {
            self.cardIdsSet = [[NSMutableSet alloc] init];
        }
    }
    return self;
}

- (void)logCardImpression:(NSString *)cardId {
    if ([self.cardIdsSet containsObject:cardId]) {
        
    } else {
        [self.cardIdsSet addObject:cardId];
        NSLog(@"<CardImpression> %@", cardId);
    }
}

- (void)logCardClick:(NSString *)cardId {
    NSLog(@"<CardClick> %@", cardId);
}

- (void)saveImpressionLogs {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cardIdsSet];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cardIdsSet"];
}

@end
