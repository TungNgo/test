#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CCBRNewsViewModel;
@protocol CCBRArticleDataSource;

@protocol CCBRCommands <NSObject>

@property (nonatomic, strong) CCBRNewsViewModel *articleCollectionViewModel;

- (void)showNewsWithDataSource:(id<CCBRArticleDataSource>)dataSource
                    startIndex:(NSUInteger)startIndex;
- (void)hideNews;

- (void)showSettings;
- (void)hideSettings;

@end

NS_ASSUME_NONNULL_END
