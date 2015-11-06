//
//  ThemeManager.h
//  XSWeibo
//
//  Created by gj on 15/9/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotificationName  @"kThemeDidChangeNotificationName"
#define kThemeName  @"kThemeName"

@interface ThemeManager : NSObject

@property (nonatomic,copy)NSString *themeName;//主题名字
@property (nonatomic,strong)NSDictionary *themeConfig;//theme.plist的内容
@property (nonatomic,strong)NSDictionary *colorConfig;//每个主题目录下 config.plist内容（颜色值）


+ (ThemeManager *)shareInstance;//单例类方法，获得唯一对象

- (UIImage *)getThemeImage:(NSString *)imageName;//根据图片名字获得对应主题包下的图片


- (UIColor *)getThemeColor:(NSString *)colorName;

@end
