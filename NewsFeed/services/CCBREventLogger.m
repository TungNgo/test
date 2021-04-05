//
//  CCBREventLogger.m
//  NewsFeed
//
//  Created by tungngo on 12/3/20.
//

#import "CCBREventLogger.h"


@interface LogItem : NSObject
@property (nonatomic, strong) NSString*cardId;
@property (nonatomic, assign) NSInteger impressionCounting;
@property (nonatomic, assign) NSInteger lickCounting;
@end

@implementation LogItem
-(id)initWithId:(NSString*)newFeedId
{
    self = [super init];
    self.impressionCounting = 0 ;
    self.lickCounting = 0 ;
    self.cardId = newFeedId ;
    return  self;
}

@end



@implementation CCBREventLogger

+ (instancetype)shared {
    static CCBREventLogger *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CCBREventLogger alloc] init];
        shared.logs =  [[NSMutableDictionary alloc] init];

    });
    return shared;
}

- (void)logCardImpression:(NSString *)cardId {
    LogItem *item = [self forceGetModelWithId:cardId] ;
    item.impressionCounting = item.impressionCounting + 1 ;
    [self.logs setValue:item forKey:cardId];
    NSLog(@"<CardImpression> %@------- : %ld", cardId,(long)item.impressionCounting);
}

- (void)logCardClick:(NSString *)cardId {
    LogItem *item = [self forceGetModelWithId:cardId] ;
    item.lickCounting = item.lickCounting + 1 ;
    [self.logs setValue:item forKey:cardId];
    NSLog(@"<CardClick> %@------- : %ld", cardId,(long)item.lickCounting);
}


-(LogItem*)forceGetModelWithId:(NSString*)cardId
{
    return [self.logs valueForKey:cardId] ? [self.logs valueForKey:cardId] : [[LogItem alloc] initWithId:cardId];
}

@end
