//
//  AppDelegate.m
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //------------集成MMDrawer-----------------
    //01 左 中 右 控制器
    MainTabBarController *tabController = [[MainTabBarController alloc] init];
    LeftViewController *leftVc = [[LeftViewController alloc] init];
    RightViewController *rightVc = [[RightViewController alloc] init];
    //02 创建 MMDrawerController
    MMDrawerController *mmDraw = [[MMDrawerController alloc] initWithCenterViewController:tabController leftDrawerViewController:leftVc rightDrawerViewController:rightVc];
    
    //设置 左边 右边 宽度
    [mmDraw setMaximumRightDrawerWidth:75.0];
    [mmDraw setMaximumLeftDrawerWidth:150];
    
    //设置手势有效区域
    [mmDraw setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmDraw setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画类型
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];

    //设置动画效果,当左右侧边栏打开或者关闭的时候执行该block内的代码
    [mmDraw
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
   // mmDraw openDrawerSide:<#(MMDrawerSide)#> animated:<#(BOOL)#> completion:<#^(BOOL finished)completion#>
    

    self.window.rootViewController = mmDraw;
    
    
    
    
    
    //----------------创建新浪微博对象------------------
    self.sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    //读取本地持久化数据（令牌  用户id ）
    [self readAuthData];
   

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 新浪微博登陆代理

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = self.sinaWeibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)readAuthData{
    //读取
    SinaWeibo *sinaweibo = self.sinaWeibo;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
}

//登陆成功
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"登陆成功");
    NSLog(@"%@,%@,%@",self.sinaWeibo.accessToken,self.sinaWeibo.userID,self.sinaWeibo.expirationDate);
    
    [self storeAuthData];
    
}
//登出成功
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"登陆失败");
    [self removeAuthData];
}
//登陆取消
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    
}
//登陆失败
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    
}


//令牌过期
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    
}





//SSO 授权回调处理 
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.sinaWeibo handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.sinaWeibo handleOpenURL:url];
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.sinaWeibo applicationDidBecomeActive];
}



@end
