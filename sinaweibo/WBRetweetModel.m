//
//  WBRetweetModel.m
//  sinaweibo
//
//  Created by kingslay on 14-1-15.
//  Copyright (c) 2014年 王 金辨. All rights reserved.
//

#import "WBRetweetModel.h"
#import "Constants.h"
@implementation WBRetweetModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    paths[@"retweet_text"] =@"retweeted_status.text";
    paths[@"thumbnail_pic"] =@"retweeted_status.thumbnail_pic";
    paths[@"original_pic"] =@"retweeted_status.original_pic";
    paths[@"retweeted_screen_name"] =@"retweeted_status.user.screen_name";
    return paths;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.identifier = retweetWeiboCellIdentifier;
    }
    return self;
}
@end
