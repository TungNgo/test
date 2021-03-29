//
//  CCBREventLogger.m
//  NewsFeed
//
//  Created by tungngo on 12/3/20.
//

#import "CCBREventLogger.h"

@interface CCBREventLogger()

@property (nonatomic, strong) NSMutableSet<NSString*> *impressionCardIds;

@end

@implementation CCBREventLogger

+ (instancetype)shared {
    static CCBREventLogger *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CCBREventLogger alloc] init];
        shared.impressionCardIds = [[NSMutableSet alloc] init];
    });
    return shared;
}

- (void)logCardImpression:(NSString *)cardId {
    if (![_impressionCardIds containsObject:cardId]) {
        NSLog(@"<CardImpression> %@", cardId);
        [_impressionCardIds addObject:cardId];
    }
}

- (void)logCardClick:(NSString *)cardId {
    NSLog(@"<CardClick> %@", cardId);
}

@end
