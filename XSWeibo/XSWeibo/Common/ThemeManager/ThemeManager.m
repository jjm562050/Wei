//
//  ThemeManager.m
//  XSWeibo
//
//  Created by gj on 15/9/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager



+ (ThemeManager *)shareInstance{
    static ThemeManager *instance = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        //Themanager
        instance = [[[self class] alloc] init ];

    });
    
  //  NSLog(@"%@",instance);
    return  instance;
    

}

- (instancetype)init{
    self = [super init];
    if (self) {
  
        //01 读取本地持久化存储的主题名字
       _themeName  =  [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        
        if (_themeName.length == 0) {
            _themeName = @"Cat";//如果本地没有存储主题名字，则用默认Cat
        }

        //02 读取 主题名-》主题路径    配置文件，放到字典里面
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        _themeConfig  = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        //03 读取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    
    return  self;
    
}

//主题切换 设置主题名字 触发通知
- (void)setThemeName:(NSString *)themeName{
    if (![_themeName isEqualToString:themeName]) {
        
        _themeName = [themeName copy];
        
        //01 把主题名字存储到plist中 NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    
        //02 重新读取颜色配置文件
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //03 发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotificationName object:nil];
    }

}

- (UIColor *)getThemeColor:(NSString *)colorName{
    
    if (colorName.length == 0) {
        return  nil;
    }
    //获取 配置文件中  rgb值
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r  = [rgbDic[@"R"] floatValue];
    CGFloat g  = [rgbDic[@"G"] floatValue];
    CGFloat b  = [rgbDic[@"B"] floatValue];
    
    CGFloat alpha = 1;
    
    
    if (rgbDic[@"alpha"] != nil) {
        alpha = [rgbDic[@"alpha"] floatValue];
    }
    //通过rgb值创建UIColor对象
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return color;
    
}


- (UIImage *)getThemeImage:(NSString *)imageName{
    //得到图片路径 
    
    //01 得到主题包路径
    NSString *themePath = [self themePath];
    //02 拼接图片路径
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    //03 读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}



//主题包路径获取
- (NSString *)themePath{
    //01 获取主题包根路径
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    
    //02 当前主题包的路径
    NSString *themePath = [self.themeConfig objectForKey:self.themeName];
    
    //03 完整路径
    NSString *path = [bundlePath stringByAppendingPathComponent:themePath];
    return path;
    
    
}





@end
