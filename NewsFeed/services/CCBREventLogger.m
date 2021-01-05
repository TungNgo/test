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
        shared.impressCardIDs = [[NSMutableSet alloc] init];
    });
    return shared;
}

- (void)logCardImpression:(NSString *)cardId {
    if (![self.impressCardIDs containsObject:cardId]) {
            NSLog(@"<CardImpression> %@", cardId);
    }
    [self.impressCardIDs addObject:cardId];
}

- (void)logCardClick:(NSString *)cardId {
    NSLog(@"<CardClick> %@", cardId);
}

@end
