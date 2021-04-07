#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CCBRArticleDataSource;

@protocol CCBRCommands <NSObject>

- (void)showNewsWithDataSource:(id<CCBRArticleDataSource>)dataSource
                    startIndex:(NSUInteger)startIndex;
- (void)showSettingScreen;

- (void)hideNews;

@end

NS_ASSUME_NONNULL_END
