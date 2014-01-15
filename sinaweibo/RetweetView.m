//
//  RetweetView.m
//  sinaweibo
//
//  Created by kingslay on 13-12-25.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "RetweetView.h"

@implementation RetweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.5f;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 1.0);
    CGContextSetAlpha(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
    CGContextMoveToPoint(context, 4.0, 4.0);
    CGContextAddLineToPoint(context, 15.0, 4.0);
    CGContextAddLineToPoint(context, 18.0, 0.0);
    CGContextAddLineToPoint(context, 21.0, 4.0);
    CGContextAddLineToPoint(context, rect.size.width - 4, 4.0);
    CGContextAddLineToPoint(context, rect.size.width - 4, rect.size.height - 2);
    CGContextAddLineToPoint(context, 4.0, rect.size.height - 2);
    CGContextAddLineToPoint(context, 4.0, 4.0);
    CGContextFillPath(context);
    CGContextStrokePath(context);
}

@end
