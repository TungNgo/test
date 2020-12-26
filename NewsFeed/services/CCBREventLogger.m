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
        shared.cardIdsSet = [[NSMutableSet alloc] init];
    });
    return shared;
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

@end
