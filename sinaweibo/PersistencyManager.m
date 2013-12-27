//
//  PersistencyManager.m
//  sinaweibo
//
//  Created by kingslay on 13-12-5.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "PersistencyManager.h"

@implementation PersistencyManager
-(UIImage *)getImage:(NSString *)fileName{
    fileName = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%i.png",fileName.hash];
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    return [UIImage imageWithData:data];
    
}
-(void *)saveImage:(UIImage *)image fileName:(NSString *)fileName{
    fileName = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%i.png",fileName.hash];
    NSData *data = UIImagePNGRepresentation(image);
    BOOL issucess = [data writeToFile:fileName atomically:YES];
}
@end
