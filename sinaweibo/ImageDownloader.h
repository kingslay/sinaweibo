//
//  ImageDownloader.h
//  sinaweibo
//
//  Created by kingslay on 13-12-21.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject
@property (atomic,strong) NSMutableArray *imageView_array;
@property (nonatomic,strong) NSString *imageURL;
@property (nonatomic,copy) void (^completionHandler)();
- (void)startDownload;
- (void)cancelDownload;
@end
