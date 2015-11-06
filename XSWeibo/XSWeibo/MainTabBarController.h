//
//  MainTabBarController.h
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface MainTabBarController : UITabBarController<SinaWeiboDelegate,SinaWeiboRequestDelegate>

@end
