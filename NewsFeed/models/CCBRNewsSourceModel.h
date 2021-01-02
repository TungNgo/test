//
//  CCBRNewsSourceModel.h
//  NewsFeed
//
//  Created by tungngo on 12/2/20.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCBRNewsSourceModel : JSONModel

@property(nonatomic, assign) NSInteger domain;
@property(nonatomic, strong) NSString* logo;
@property(nonatomic, strong) NSString* title;

@end

NS_ASSUME_NONNULL_END
