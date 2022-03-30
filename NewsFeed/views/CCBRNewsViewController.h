//
//  CCBRArticleCollectionViewController.h
//  NewsFeed
//
//  Created by tungngo on 10/15/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CCBRNewsViewModel;
@protocol CCBRCommands;

@interface CCBRNewsViewController : UIViewController

- (instancetype)initWithViewModel:(CCBRNewsViewModel*)viewModel
dispatcher:(id<CCBRCommands>)dispatcher;

@end

NS_ASSUME_NONNULL_END
