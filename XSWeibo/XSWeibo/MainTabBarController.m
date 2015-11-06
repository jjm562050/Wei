
//
//  MainTabBarController.m
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "ThemeLabel.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController{
    ThemeImageView *_selectedImageView;
    ThemeLabel *_badgeLabel;
    ThemeImageView *_badgeImageView;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建子视图控制器
    [self _createSubControllers];
    //设置 tabbar
    [self _createTabBar];
    
    
    //开启定时器,请求unread_count接口 获取未读微博、新粉丝数量、新评论。。。
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)_createTabBar{
    //01 移除tabBarButton
    //UITabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    //02 tabBar背景图片: 创建imageView 作为 子视图 添加到 tabBar上
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 49)];
    bgImageView.imgName = @"mask_navbar.png";
    [self.tabBar addSubview:bgImageView];
    
   
    //03 选中图片
    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 49)];
    _selectedImageView.imgName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImageView];
    

    //04 tabbar 标签button
    CGFloat itemWidth = kScreenWidth/4;

    //加入主题管家管理图片
    NSArray *imageNames =@[
                               @"home_tab_icon_1.png",
                              // @"home_tab_icon_2.png",
                               @"home_tab_icon_3.png",
                               @"home_tab_icon_4.png",
                               @"home_tab_icon_5.png",
                               
                               ];
    

    for (int i = 0; i<imageNames.count; i++) {
        
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, 49)];
     
        button.normalImageName = imageNames[i];
        button.tag = i;
        [button addTarget:self action:@selector(_selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        
        
    }
    
}
- (void)_selectAction:(UIButton *)button{
    
    [UIView animateWithDuration:0.3 animations:^{
        
          _selectedImageView.center = button.center;
    }];
    
    
  
    self.selectedIndex = button.tag;
    
}



- (void)_createSubControllers{

    NSArray *names = @[@"Home",@"Profile",@"Discover",@"More"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:names.count];
    for ( int i  = 0; i<4; i++) {
        NSString *name = names[i];
        //创建storyBoard对象
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        
        //通过 storyBoard创建控制器对象
        BaseNavController *navVc = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:navVc];
    
    }
    self.viewControllers = navArray;
}

#pragma mark - 未读系消息个数获取
- (void)timerAction{
    
    //请求数据
    AppDelegate *appDelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    //number_notify_9.png
    //Timeline_Notice_color
    //未读微博
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    CGFloat tabBarButtonWidth = kScreenWidth/4;
    if (_badgeImageView == nil) {
        _badgeImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _badgeImageView.imgName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeImageView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImageView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font =[UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        [_badgeImageView addSubview:_badgeLabel];

    }
    if (count > 0) {
        _badgeImageView.hidden = NO;
        if (count > 99) {
            count = 99;
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
    }else{
        
        _badgeImageView.hidden = YES;
        
    }
    
    
}




@end
