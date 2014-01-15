//
//  WBModel.h
//  sinaweibo
//
//  Created by kingslay on 14-1-15.
//  Copyright (c) 2014年 王 金辨. All rights reserved.
//
#import <Mantle.h>
#import <UIKit/UIKit.h>
@interface WBModel : MTLModel<MTLJSONSerializing>
//字符串型的微博ID
@property (strong, nonatomic) NSString *idstr;
//用户头像地址（中图），50×50像素
@property (strong, nonatomic) NSString *profile_image_url;
//用户昵称
@property (strong, nonatomic) NSString *screen_name;
//微博信息内容
@property (strong, nonatomic) NSString *text;
//微博来源
@property (strong, nonatomic) NSString *source;
//缩略图片地址，没有时不返回此字段
@property (strong, nonatomic) NSString *thumbnail_pic;
//原始图片地址，没有时不返回此字段
@property (strong, nonatomic) NSString *original_pic;
@property (strong, nonatomic) NSString *identifier;
@end
