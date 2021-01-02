#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CCBRArticleDataSource;

@protocol CCBRCommands <NSObject>

- (void)showNewsWithDataSource:(id<CCBRArticleDataSource>)dataSource
                    startIndex:(NSUInteger)startIndex;
- (void)hideNews;
- (void)showSettings;
- (void)hideSettings;
- (void)showMenu;
- (void)hideMenu;

@end

NS_ASSUME_NONNULL_END
