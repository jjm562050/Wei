//
//  BaseNavController.m
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

-  (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

//当xib创建出来对象 的时候调用该init方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //注册通知监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return  self;
    
 
}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadImage];
}


- (void)loadImage{
    
    //  主题管家对象
    
    ThemeManager *manager = [ThemeManager shareInstance];
    
    //01 修改导航栏 背景
    UIImage *image = [manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //02 修改主题文字颜色
    
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:color};

    self.navigationBar.titleTextAttributes = attrDic ;
    
    //03 修改视图背景

    UIImage *bgImage = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    
    //04 导航栏按钮文字颜色
    
    self.navigationBar.tintColor = color;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadImage];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
