//
//  ImageDownloader.m
//  sinaweibo
//
//  Created by kingslay on 13-12-21.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "ImageDownloader.h"
@interface ImageDownloader () <NSURLConnectionDataDelegate> {
    NSMutableData* actionDowload;
    NSURLConnection* imageConnection;
}
@end
@implementation ImageDownloader
- (id)init
{
    if (self) {
        _imageView_array = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)startDownload
{
    actionDowload = [NSMutableData data];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:_imageURL]];
    imageConnection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];
}
- (void)cancelDownload
{
    [imageConnection cancel];
    imageConnection = Nil;
    actionDowload = nil;
}
#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [actionDowload appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    actionDowload = nil;
    imageConnection = nil;
}
- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    UIImage* image = [UIImage imageWithData:actionDowload];
    for (UIImageView* imageView in _imageView_array) {
        imageView.image = image;
    }
    actionDowload = nil;
    imageConnection = nil;
    if (_completionHandler) {
        _completionHandler();
    }
}
@end
