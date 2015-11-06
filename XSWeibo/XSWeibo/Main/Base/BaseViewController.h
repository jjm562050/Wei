//
//  BaseViewController.h
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperation.h"
@interface BaseViewController : UIViewController{
    UIView *_tipView; //屏幕中央加载提示
    MBProgressHUD *_hud;
    
    
    UIWindow *_tipWindow;//在状态栏上显示 微博发送进度

    
    
}
- (void)setNavItem;
//自己实现加载提示
- (void)showLoading:(BOOL)show;


//第三方 MBProgressHUD

- (void)showHUD:(NSString *)title;

- (void)hideHUD;
- (void)completeHUD:(NSString *)title;

//设置背景图片
- (void)setBgImage;



//状态栏 提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;

@end
