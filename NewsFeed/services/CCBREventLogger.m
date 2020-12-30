//
//  CCBREventLogger.m
//  NewsFeed
//
//  Created by tungngo on 12/3/20.
//

#import "CCBREventLogger.h"

@interface CCBREventLogger () {
    NSMutableSet<NSString *> *impressionIds;
}

@end

@implementation CCBREventLogger

+ (instancetype)shared {
    static CCBREventLogger *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CCBREventLogger alloc] init];
    });
    return shared;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        impressionIds = [NSMutableSet new];
    }
    return self;
}

- (void)logCardImpression:(NSString *)cardId {
    if (![impressionIds containsObject:cardId]) {
        NSLog(@"<CardImpression> %@", cardId);
    }
    
    [impressionIds addObject:cardId];
}

- (void)logCardClick:(NSString *)cardId {
    NSLog(@"<CardClick> %@", cardId);
}

@end
