//
//  PersistencyManager.h
//  sinaweibo
//
//  Created by kingslay on 13-12-5.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistencyManager : NSObject
- (UIImage*)getImage:(NSString*)fileName;
- (void*)saveImage:(UIImage*)image fileName:(NSString*)fileName;
@end
