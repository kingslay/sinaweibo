//
//  CustomCellBackView.m
//  sinaweibo
//
//  Created by kingslay on 13-12-27.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "CustomCellBackView.h"

@implementation CustomCellBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = false;
        self.alpha = 0.5f;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 0.5f);

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(
        context, CGRectMake(4, 2, rect.size.width - 8, rect.size.height - 4));
}
@end
