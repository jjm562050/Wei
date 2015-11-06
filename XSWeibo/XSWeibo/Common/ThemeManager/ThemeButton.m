//
//  ThemeButton.m
//  XSWeibo
//
//  Created by gj on 15/9/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //注册通知监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}


- (void)setNormalImageName:(NSString *)normalImageName{
    if (![_normalImageName isEqualToString:normalImageName]) {
        _normalImageName = [normalImageName copy];

        [self loadImage];
    }

}

- (void)setHighlightedImageName:(NSString *)highlightedImageName{

    if (![_highlightedImageName isEqualToString:highlightedImageName] ) {
        _highlightedImageName = [highlightedImageName  copy];
        [self loadImage];
    }
}

//收到通知后重新加载图片
- (void)themeDidChange:(NSNotification *)notification{
    //重新加载图片
    [self loadImage];
}


- (void)loadImage{
    
    //得到主题管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    //通过管家得到图片
    UIImage *normalImage = [manager getThemeImage:self.normalImageName];
    UIImage *highlightedImage = [manager getThemeImage:self.highlightedImageName];
    
    //设置图片
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightedImage != nil) {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    
}

@end
