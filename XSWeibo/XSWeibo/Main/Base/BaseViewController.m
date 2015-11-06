//
//  BaseViewController.m
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeManager.h"
#import "UIProgressView+AFNetworking.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
  //  [self setNavItem];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置导航栏左右按钮
- (void)setNavItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem alloc] initWithImage:<#(UIImage *)#> landscapeImagePhone:<#(UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(id)#> action:<#(SEL)#>
    //UIBarButtonItem *item = [UIBarButtonItem alloc] initWithCustomView:<#(UIView *)#>
    
}
- (void)setAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
   [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)editAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}


- (void)showLoading:(BOOL)show{
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2-30, kScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        
        //01 activity
        UIActivityIndicatorView *activiyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activiyView.tag = 100;
        [_tipView addSubview:activiyView];
        
        
        //02 label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"正在加载。。。";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];
        

        [_tipView addSubview:label];
        
        
        label.left = (kScreenWidth-label.width)/2;
        activiyView.right = label.left-5;
    
    }
    if (show) {
        UIActivityIndicatorView *activiyView = [_tipView viewWithTag:100];
        [activiyView startAnimating];
        [self.view addSubview:_tipView];
    }else{
        if (_tipView.superview) {
            UIActivityIndicatorView *activiyView = [_tipView viewWithTag:100];
            [activiyView stopAnimating];
            [_tipView removeFromSuperview];
        }
    }
    
    
    
}

- (void)showHUD:(NSString *)title{
    
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [_hud show:YES];
    _hud.labelText = title;
    
    //灰色背景视图覆盖掉其他视图
    _hud.dimBackground = YES;
    //_hud.detailsLabelText = @"测试测试";
    
}
- (void)hideHUD{
    
    [_hud hide:YES];
}

- (void)completeHUD:(NSString *)title{
    
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;

    //持续1.5隐藏
    [_hud hide:YES afterDelay:1.5];
    
}

#pragma -mark 设置背景图片
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotificationName object:nil];
    
    [self _loadImage];
}

- (void)_loadImage{
    
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *img = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
}



#pragma  mark - 状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation{

    if (_tipWindow == nil) {
        //01 创建window
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //02 显示文字 label
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.backgroundColor = [UIColor clearColor];
        tpLabel.textAlignment = NSTextAlignmentCenter;
        tpLabel.font = [UIFont systemFontOfSize:13];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 100;
        [_tipWindow addSubview:tpLabel];
        
        
        //03 进度条
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 20-3, kScreenWidth, 5);
        progressView.tag = 101;
        progressView.progress = 0.0;
        [_tipWindow addSubview:progressView];
    }
    
    UILabel *tpLabel = (UILabel*)[_tipWindow viewWithTag:100];
    tpLabel.text = title;
    
    
    UIProgressView *progressView = (UIProgressView *)[_tipWindow viewWithTag:101];
    
    
    if (show) {
        _tipWindow.hidden = NO;
        
        if (operation != nil) {
            progressView.hidden = NO;
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else{
            progressView.hidden = YES;
        }
    
    }else{
     
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }

}


- (void)removeTipWindow{
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
}

@end
