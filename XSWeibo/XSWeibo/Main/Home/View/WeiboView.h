//
//  WeiboView.h
//  XSWeibo
//
//  Created by gj on 15/9/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLayoutFrame.h"
#import "WXLabel.h"
#import "ThemeManager.h"
#import "ZoomImageView.h"

@interface WeiboView : UIView<WXLabelDelegate>

@property (nonatomic,strong)WXLabel *textLabel;//微博文字
@property (nonatomic,strong)WXLabel *sourceLabel;//如果转发则：原微博文字
@property (nonatomic,strong)ZoomImageView  *imgView;// 微博图片
@property (nonatomic,strong)ThemeImageView *bgImageView;//原微博背景图片


@property (strong,nonatomic) WeiboViewLayoutFrame *layoutFrame;//布局对象
@end
