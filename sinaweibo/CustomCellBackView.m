//
//  CustomCellBackView.m
//  sinaweibo
//
//  Created by kingslay on 13-12-27.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "CustomCellBackView.h"

@implementation CustomCellBackView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.selected) {
         CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextFillRect(context,rect);

    }else{
        CGContextSetFillColorWithColor(context, [UIColor groupTableViewBackgroundColor].CGColor);
        CGContextFillRect(context,rect);
        CGContextSetFillColorWithColor(context, [UIColor groupTableViewBackgroundColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(4, 2, rect.size.width-8, rect.size.height-4));

    }
    
}
@end
