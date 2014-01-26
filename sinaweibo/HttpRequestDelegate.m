//
//  HttpRequestDelegate.m
//  sinaweibo
//
//  Created by kingslay on 13-12-26.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "HttpRequestDelegate.h"
#import "PubUtil.h"
#import "WeiBoViewController.h"
#import "WBModel.h"

@implementation HttpRequestDelegate
#pragma mark - WBHttpRequestDelegate Methods

/**
 收到一个来自微博Http请求的响应

 @param response 具体的响应对象
 */
- (void)request:(WBHttpRequest *)request
    didReceiveResponse:(NSURLResponse *)response {
}

/**
 收到一个来自微博Http请求失败的响应

 @param error 错误信息
 */
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
  NSLog(@"requestDidFailWithError: %@", error);
}

/**
 收到一个来自微博Http请求的网络返回

 @param result 请求返回结果
 */
- (void)request:(WBHttpRequest *)request
    didFinishLoadingWithResult:(NSString *)result {
}

/**
 收到一个来自微博Http请求的网络返回

 @param data 请求返回结果
 */
- (void)request:(WBHttpRequest *)request
    didFinishLoadingWithDataResult:(NSData *)data {
  NSDictionary *dict =
      [NSJSONSerialization JSONObjectWithData:data
                                      options:NSJSONReadingMutableContainers
                                        error:NULL];

  NSMutableArray *otherArray = [[NSMutableArray alloc] init];
  for (NSDictionary *JSONDictionary in [dict objectForKey:@"statuses"]) {
    [otherArray addObject:[MTLJSONAdapter modelOfClass:[WBModel class]
                                    fromJSONDictionary:JSONDictionary
                                                 error:nil]];
  }
  if ([otherArray count] > 0) {
    UINavigationController *navBar =
        (UINavigationController *)[[UIApplication sharedApplication] delegate]
            .window.rootViewController;

    WeiBoViewController *weiBoViewController =
        (WeiBoViewController *)[navBar topViewController];
    if ([request.tag isEqualToString:@"refresh"]) {
      [PubUtil.timeLine removeAllObjects];
      [PubUtil.timeLine addObjectsFromArray:otherArray];
    } else if ([request.tag isEqualToString:@"loadMore"]) {
      [PubUtil.timeLine addObjectsFromArray:otherArray];
    } else if ([request.tag isEqualToString:@"loadNew"]) {
      NSIndexSet *indexSet = [NSIndexSet
          indexSetWithIndexesInRange:NSMakeRange(0, [otherArray count])];
      [PubUtil.timeLine insertObjects:otherArray atIndexes:indexSet];
    }
    [weiBoViewController.tableView reloadData];
  }
}
@end
