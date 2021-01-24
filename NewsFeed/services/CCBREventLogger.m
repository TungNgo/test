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

- (void)logCardImpression:(NSString *)cardId {
    NSString* impressionCardId = [NSUserDefaults.standardUserDefaults stringForKey:cardId];
    if (impressionCardId != cardId) {
        [NSUserDefaults.standardUserDefaults setValue:cardId forKey:cardId];
        NSLog(@"<CardImpression> %@", cardId);
    } else {
        return;
    }
}

- (void)logCardClick:(NSString *)cardId {
    NSLog(@"<CardClick> %@", cardId);
}

@end
