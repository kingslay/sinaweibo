//
//  AppDelegate.m
//  sinaweibo
//
//  Created by 王 金辨 on 12-9-24.
//  Copyright (c) 2012年 王 金辨. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "PubUtil.h"
#import <Weibo/WeiboSDK.h>
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  if (isRunningTests()) {
    return YES;
  }
  [application
      registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert];
  return YES;
}
static BOOL isRunningTests(void) {
  NSDictionary *environment = [[NSProcessInfo processInfo] environment];
  NSString *injectBundle = environment[@"XCInjectBundle"];
  return [[injectBundle pathExtension] isEqualToString:@"octest"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down
  // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
}

- (BOOL)application:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
  return [WeiboSDK handleOpenURL:url delegate:self];
}
/**
 收到一个来自微博客户端程序的请求

 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过
 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
}

/**
 收到一个来自微博客户端程序的响应

 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和
 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
  if ([response isKindOfClass:WBAuthorizeResponse.class]) {
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
      [[NSUserDefaults standardUserDefaults]
          setObject:[(WBAuthorizeResponse *)response accessToken]
             forKey:WBSDKaccessToken];
        [PubUtil refresh];

    } else {
      NSString *title = @"认证结果";
      NSString *message = [NSString
          stringWithFormat:
              @"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: "
               "%@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
              response.statusCode, [(WBAuthorizeResponse *)response userID],
              [(WBAuthorizeResponse *)response accessToken], response.userInfo,
              response.requestUserInfo];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];

      [alert show];
    }
  }
}

@end
