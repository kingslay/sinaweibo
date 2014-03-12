//
//  WBPubUtil.m
//  sinaweibo
//
//  Created by 王 金辨 on 12-10-10.
//  Copyright (c) 2012年 王 金辨. All rights reserved.
//
#import "Constants.h"
#import "PubUtil.h"
#import "AppDelegate.h"
#import "HttpRequestDelegate.h"
#import "PersistencyManager.h"
#import "ImageDownloader.h"
#import <Weibo/WeiboSDK.h>
#import "WBModel.h"

@implementation PubUtil

static HttpRequestDelegate *_requestDelegate;

static UIImage *_placeholder_profile_image;
static UIImage *_placeholder_thumbnail_pic;
static NSMutableArray *_timeLine;
static NSString *token;

+ (void)initialize {
  if (self == [PubUtil class]) {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WBSDKDemoAppKey];
    _placeholder_profile_image = [UIImage imageNamed:@"head.png"];
    _placeholder_thumbnail_pic = [UIImage imageNamed:@"picture.png"];
    _requestDelegate = [[HttpRequestDelegate alloc] init];
    _timeLine = [[NSMutableArray alloc] init];
  }
}
+ (void)loadIn {
  WBAuthorizeRequest *request = [WBAuthorizeRequest request];
  request.redirectURI = WBSDKRedirectURI;
  request.scope = @"all";
  request.userInfo = @{ @"SSO_From" : @"PubUtil" };
  [WeiboSDK sendRequest:request];
}
+ (void)httpRequestWithParams:(NSDictionary *)params withTag:tag {
    if(!token) {
        token =
        [[NSUserDefaults standardUserDefaults] objectForKey:WBSDKaccessToken];
        if(!token) {
            [self loadIn];
        }
    }
  [WBHttpRequest requestWithAccessToken:token
                                    url:@"https://api.weibo.com/2/statuses/"
                                         "home_timeline.json"
                             httpMethod:@"GET"
                                 params:params
                               delegate:_requestDelegate
                                withTag:tag];
}
+ (void)refresh {
  [self httpRequestWithParams:nil withTag:@"refresh"];
}
+ (void)loadMore {

  WBModel *model = [_timeLine lastObject];

  long long i = [model.idstr doubleValue];
  i--;
  [self httpRequestWithParams:
          @{
            @"max_id" : [[NSNumber numberWithLongLong:i] stringValue]
          }
                      withTag:@"loadMore"];
}
+ (void)loadNew {
  WBModel *model = [_timeLine firstObject];
  if (model) {
    [self httpRequestWithParams:@{
                                  @"since_id" : model.idstr
                                }
                        withTag:@"loadNew"];
  } else {
    [self refresh];
  }
}

+ (UIImage *)placeholder_profile_image {
  return _placeholder_profile_image;
}
+ (UIImage *)placeholder_thumbnail_pic {
  return _placeholder_thumbnail_pic;
}
+ (NSMutableArray *)timeLine {
  return _timeLine;
}
@end
