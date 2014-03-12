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
#pragma mark - WeiboSDKDelegate Methods

/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
}

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
