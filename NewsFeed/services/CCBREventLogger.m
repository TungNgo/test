//
//  CCBREventLogger.m
//  NewsFeed
//
//  Created by tungngo on 12/3/20.
//

#import "CCBREventLogger.h"
#import "Constants.h"

@interface CCBREventLogger()

@property (nonatomic, strong) NSMutableSet *impressedCardIDs;

@end

@implementation CCBREventLogger

+ (instancetype)shared {
    static CCBREventLogger *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CCBREventLogger alloc] init];
        
        NSArray *cardIDs = [[NSUserDefaults standardUserDefaults] arrayForKey:CCBRImpressedCardIDsKey];
        shared.impressedCardIDs = [[NSMutableSet alloc] initWithArray:cardIDs];
    });
    return shared;
}

- (void)logCardImpression:(NSString *)cardId {
    if (![self isCardImpressed:cardId]) {
        NSLog(@"<CardImpression> %@", cardId);
        [self.impressedCardIDs addObject:cardId];
    }
}

- (void)logCardClick:(NSString *)cardId {
    NSLog(@"<CardClick> %@", cardId);
}

// MARK: - Utilities
- (void)createANewAppLogIfNeeded {
    NSString *appLogPath = PathForFileName(CCBRConsoleLogFileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = FALSE;
    NSError *error;
    
    if ( [[fileManager attributesOfItemAtPath:appLogPath error:&error] fileSize] > CCBRConsoleLogFileSize ) {
        NSString *appLog0 = PathForFileName(CCBROldConsoleLogFileName);
        
        if ( [fileManager fileExistsAtPath:appLog0] ) {
            //Remove the old event log file
            [fileManager removeItemAtPath:appLog0 error:&error];
        }
        
        //Temprarily save the oversize event log file
        success = [fileManager copyItemAtPath:appLogPath toPath:appLog0 error:&error];
        if ( success ) {
            //Delete
            success = [fileManager removeItemAtPath:appLogPath error:&error];
            
            if ( success ) {
                // Redirect NSLog output to file for DEBUG and ADHOC builds so that users
                // can retrieve using iTunes desktop application.
                freopen([appLogPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
            }
            else {
                //Still using the oversize file
            }
        }
        else {
            //Still using the oversize file
        }
    }
}

- (BOOL)isCardImpressed:(NSString *)cardID {
    return [self.impressedCardIDs containsObject:cardID];
}

- (void)storeImpressedCardIDs {
    [[NSUserDefaults standardUserDefaults] setObject:[self.impressedCardIDs allObjects] forKey:CCBRImpressedCardIDsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
