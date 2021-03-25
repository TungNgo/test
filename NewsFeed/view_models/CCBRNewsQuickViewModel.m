//
//  CCBRArticlePreviewViewModel.m
//  NewsFeed
//
//  Created by tungngo on 10/13/20.
//

#import "CCBRNewsQuickViewModel.h"

#import "CCBRNewsArticleModel.h"
#import "CCBRNewsSourceModel.h"
#import "CCBREventLogger.h"

@interface CCBRNewsQuickViewModel ()

@property(nonatomic, strong)CCBRNewsArticleModel*model;

@end

@implementation CCBRNewsQuickViewModel

- (instancetype)initWithModel:(CCBRNewsArticleModel*)model{
    self = [super init];
    if (self) {
        self.model = model;
        self.isLoggedImpression = NO;
    }
    return self;
}

- (NSString*)title {
    return self.model.title;
}

- (NSString*)url {
    return self.model.url;
}

- (NSString*)domain {
    return self.model.domain;
}

- (UIImage *)favicon {
    NSString *header = @"data:image/png;base64,";
    NSString *logo = self.model.source.logo;
    if (!logo || logo.length < header.length) {
        return nil;
    }
    logo = [logo substringFromIndex:header.length];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:logo options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (BOOL)shouldShowSwipeHint {
    return YES;
}

#pragma mark - Log Card Impression

- (void)logCardImpression: (NSURL *)url {
    if (![self.model.newsFeedId isEqualToString:@""] && [url.absoluteString isEqualToString:self.model.url] && !self.isLoggedImpression) {
        [[CCBREventLogger shared] logCardImpression:self.model.newsFeedId];
        self.isLoggedImpression = YES;
    }
}

@end
