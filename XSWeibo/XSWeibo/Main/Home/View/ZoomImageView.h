//
//  ZoomImageView.h
//  XSWeibo
//
//  Created by gj on 15/9/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoomImageView;


//定义协议，当图片放大或缩小的时候调用
@protocol ZoomImageViewDelegate <NSObject>
@optional

//图片将要放大

- (void)imageWillZoomIn:(ZoomImageView *)imageView;

//将要缩小
- (void)imageWillZoomOut:(ZoomImageView *)imageView;
//已经放大
//已经缩小
//....

@end






@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate>{
    
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
}

@property (nonatomic,weak) id<ZoomImageViewDelegate> delegate;
@property (nonatomic,strong) NSString *fullImageUrlString;

//gif处理
@property (nonatomic,assign) BOOL isGif;
@property (nonatomic,strong) UIImageView  *iconView;


@end
