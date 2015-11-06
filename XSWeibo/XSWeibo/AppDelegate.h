//
//  AppDelegate.h
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SinaWeibo *sinaWeibo;//_sinaWeibo

@end

