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

@implementation PubUtil

static HttpRequestDelegate *_requestDelegate;

static UIImage *_placeholder_profile_image;
static UIImage *_placeholder_thumbnail_pic;
static NSMutableArray *_timeLine;
static NSString *token;

+(void)initialize
{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WBSDKDemoAppKey];
    _placeholder_profile_image =[UIImage imageNamed:@"head.png"];
    _placeholder_thumbnail_pic =[UIImage imageNamed:@"picture.png"];
    _requestDelegate = [[HttpRequestDelegate alloc]init];
    _timeLine = [[NSMutableArray alloc] init];
    token = [[NSUserDefaults standardUserDefaults] objectForKey:WBSDKaccessToken];
    while(!token) {
        [self loadIn];
        token = [[NSUserDefaults standardUserDefaults] objectForKey:WBSDKaccessToken];
    }
}
+(void)loadIn
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WBSDKRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"PubUtil",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    
}
+(void) httpRequestWithParams:(NSDictionary *)params withTag:tag
{
    [WBHttpRequest requestWithAccessToken:token url:@"https://api.weibo.com/2/statuses/home_timeline.json" httpMethod:@"GET" params:params delegate:_requestDelegate withTag:tag];
}
+ (void)refresh
{
    [self httpRequestWithParams:nil withTag:@"refresh"];
}
+(void)loadMore
{
    
    NSDictionary *dic=[_timeLine lastObject];;
    NSNumber *max_id =[dic objectForKey:@"id"];
    long long i = [max_id longLongValue];
    i--;
    [self httpRequestWithParams:@{@"max_id":[[NSNumber numberWithLongLong:i] stringValue]} withTag:@"loadMore"];

}
+(void)loadNew
{
    
    NSDictionary *dic=[_timeLine firstObject];;
    NSNumber *since_id=[dic objectForKey:@"id"];
    [self httpRequestWithParams:@{@"since_id":[since_id stringValue]} withTag:@"loadNew"];
}

+(UIImage *)placeholder_profile_image
{
    return _placeholder_profile_image;
}
+(UIImage *)placeholder_thumbnail_pic
{
    return _placeholder_thumbnail_pic;
}
+(NSMutableArray *)timeLine
{
    return _timeLine;
}
@end
