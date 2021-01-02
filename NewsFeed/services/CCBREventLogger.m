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
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[[paths firstObject] stringByAppendingPathComponent:@"cardIds"] stringByAppendingPathExtension:@"plist"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[[paths firstObject] stringByAppendingPathComponent:@"cardIds"] stringByAppendingPathExtension:@"plist"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cardIdsSet];
    [data writeToFile:filePath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cardIdsSet"];
}

@end
