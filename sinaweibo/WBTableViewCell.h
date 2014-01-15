//
//  WBTableViewCell.h
//  sinaweibo
//
//  Created by 王 金辨 on 12-10-11.
//  Copyright (c) 2012年 王 金辨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBModel.h"

@interface WBTableViewCell : UITableViewCell
//自定义图像
@property (strong, nonatomic) IBOutlet UIImageView *profile_image;
@property (strong, nonatomic) IBOutlet UILabel *screen_name;
@property (strong, nonatomic) IBOutlet UILabel *text;
//缩略图
@property (strong, nonatomic) IBOutlet UIImageView *thumbnail_pic;
@property (strong, nonatomic) IBOutlet UILabel *retweettext;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UIView *retweetview;

@property (strong, nonatomic) NSString *original_pic_URL;
- (void)initDataByModel:(WBModel *)model tableView:(UITableView *)tableVie;
@end
