//
//  WBRetweetModel.h
//  sinaweibo
//
//  Created by kingslay on 14-1-15.
//  Copyright (c) 2014年 王 金辨. All rights reserved.
//

#import "WBModel.h"

@interface WBRetweetModel : WBModel
//转发微博信息内容
@property (strong, nonatomic) NSString *retweet_text;
@property (strong, nonatomic) NSString *retweeted_screen_name;

@end
