//
//  WBModel.m
//  sinaweibo
//
//  Created by kingslay on 14-1-15.
//  Copyright (c) 2014年 王 金辨. All rights reserved.
//
#import "Constants.h"
#import "WBModel.h"
#import "WBRetweetModel.h"

@implementation WBModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
     return @{
              @"idstr":@"idstr",
              @"screen_name":@"user.screen_name",
              @"text":@"text",
              @"source":@"source",
              @"thumbnail_pic":@"thumbnail_pic",
              @"original_pic":@"original_pic",
              @"profile_image_url":@"user.profile_image_url",
              };
}
+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary{
    if (JSONDictionary[@"retweeted_status"]){
        return [WBRetweetModel class];
    }else{
        return [self class];
    }
}
- (id)init
{
    self = [super init];
    if (self) {
        self.identifier = weiboCellIdentifier;
    }
    return self;
}

@end
