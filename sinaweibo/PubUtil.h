//
//  WBPubUtil.h
//  sinaweibo
//
//  Created by 王 金辨 on 12-10-10.
//  Copyright (c) 2012年 王 金辨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBTableViewCell.h"

@interface PubUtil : NSObject
+ (void)refresh;
+ (void)loadNew;
+ (void)loadMore;
+ (NSMutableArray *) timeLine;
+ (UIImage *)placeholder_profile_image;
+ (UIImage *)placeholder_thumbnail_pic;
+ (void)loadIn;

@end

