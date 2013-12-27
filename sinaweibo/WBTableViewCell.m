//
//  WBTableViewCell.m
//  sinaweibo
//
//  Created by 王 金辨 on 12-10-11.
//  Copyright (c) 2012年 王 金辨. All rights reserved.
//

#import "WBTableViewCell.h"
#import "PubUtil.h"
#import "ImageViewController.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomCellBackView.h"
@implementation WBTableViewCell
-(void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)showImageView{
    ImageViewController *controller = [[ImageViewController alloc]init];
    [controller show:self.original_pic_URL];
}
-(void)adjustTextHeight:(UILabel *)label
{
    
    CGSize size=[label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width,MAXFLOAT)];
    //高度要向上取整。这个才不会有问题
    size.height = ceil(size.height);
    //    CGRect frame=[label textRectForBounds:label.frame limitedToNumberOfLines:0];
    CGRect frame=label.frame;
    CGFloat difference = size.height - frame.size.height;
    if (difference !=0) {
        label.frame = CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,size.height);
        frame = self.frame;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+difference);
    }
    
}
- (void)initDataByDict:(NSDictionary *)detail tableView:(UITableView *)tableVie
{
    self.backgroundView = [[CustomCellBackView alloc]initWithFrame:self.frame];
    CustomCellBackView *selectedCellBackView = [[CustomCellBackView alloc]initWithFrame:self.frame];
    selectedCellBackView.selected = true;
    self.selectedBackgroundView = selectedCellBackView;
    [self.profile_image setImageWithURL:[NSURL URLWithString:detail[@"user"][@"profile_image_url"]] placeholderImage:[PubUtil placeholder_profile_image]];
    
    //用户名
    [self.name setText:detail[@"user"][@"screen_name"]];
    //内容
    [self.text setText:detail[@"text"]];
    [self adjustTextHeight:self.text];
    //来源
    self.source.text                = [NSString stringWithFormat:@"来自%@",[self source:[detail objectForKey:@"source"]]];
    NSString *thumbnail_pic_url     = detail[@"thumbnail_pic"];
    self.original_pic_URL           = detail[@"original_pic"];
    if ([detail objectForKey:@"retweeted_status"]){
        thumbnail_pic_url               = detail[@"retweeted_status"][@"thumbnail_pic"];
        self.original_pic_URL           = detail[@"retweeted_status"][@"original_pic"];
        NSString *retweettext = [[NSString alloc] initWithFormat:@"@%@:  %@",
                                 detail[@"retweeted_status"][@"user"][@"screen_name"],
                                 detail[@"retweeted_status"][@"text"]];
        self.retweettext.text           = retweettext;
        [self adjustTextHeight:self.retweettext];
        
    }
    if (thumbnail_pic_url) {
        [self.thumbnail_pic setImageWithURL:[NSURL URLWithString:thumbnail_pic_url] placeholderImage:[PubUtil placeholder_thumbnail_pic]];
        
        [self.thumbnail_pic addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageView)]];
    }else{
        CGRect frame                    = self.frame;
        frame.size.height               = frame.size.height - self.thumbnail_pic.frame.size.height;
        self.frame = frame;
        [self.thumbnail_pic removeFromSuperview];
    }
    
}
-(NSString *) source:(NSString *) source_url
{
    NSString *source;
    NSScanner *scanner              = [NSScanner scannerWithString:source_url];
    [scanner scanUpToString:@">" intoString:nil];
    [scanner scanString:@">" intoString:nil];
    [scanner scanUpToString:@"</a>" intoString:&source];
    return source;
}
@end
