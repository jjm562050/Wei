//
//  UIView+ViewController.m
//  XSWeibo
//
//  Created by gj on 15/9/15.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *)viewController{
    
    //下一个响应者
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        //判断响应者类型是都是视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
    
    
}
@end
