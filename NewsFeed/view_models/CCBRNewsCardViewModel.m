//
//  CCBRArticleItemViewModel.m
//  NewsFeed
//
//  Created by tungngo on 10/15/20.
//

#import "CCBRNewsCardViewModel.h"

#import "CCBRNewsArticleModel.h"
#import "CCBRNewsSourceModel.h"

@interface CCBRNewsCardViewModel ()

@property(nonatomic, strong) CCBRNewsArticleModel *model;

@end

@implementation CCBRNewsCardViewModel

- (instancetype)initWithModel:(CCBRNewsArticleModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (NSURL *)thumbnailURL {
    return [NSURL URLWithString:self.model.imageUrl];
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

- (NSString *)sourceText {
    return self.model.source.title;
}

- (NSString*)titleText {
    return self.model.title;
}

- (NSString*)timeText {
    NSDate *date;
    
    static NSDateFormatter *dateParser = nil;
    dateParser = [[NSDateFormatter alloc] init];
    dateParser.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    date = [dateParser dateFromString:self.model.eventTime];
    
    static NSDateFormatter *dateFormatter = nil;
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yy";
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString && dateString.length > 0? [NSString stringWithFormat:@"- %@", dateString]: @"";
}

- (NSString *)descriptionText {
    return self.model.desc;
}


//
- (NSString *)newsFeedId{
    return self.model.newsFeedId;
}

@end
