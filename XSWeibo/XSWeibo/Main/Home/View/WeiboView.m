//
//  WeiboView.m
//  XSWeibo
//
//  Created by gj on 15/9/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"



@implementation WeiboView
//xib文件创建
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    
//}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



//alloc
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubViews];
    }
    return self;
}

- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
    
}



- (void)_createSubViews{
    _textLabel.backgroundColor = [UIColor redColor];
    _sourceLabel.backgroundColor = [UIColor yellowColor];
    
    
    //1 微博内容
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _textLabel.wxLabelDelegate = self;
    _textLabel.linespace = 5;
    //_textLabel.font = [UIFont systemFontOfSize:15];
      _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    [self addSubview:_textLabel];
    
    //2 原微博内容
    _sourceLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.wxLabelDelegate =self;
    _sourceLabel.linespace = 5;
    //_sourceLabel.font = [UIFont systemFontOfSize:14];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
    [self addSubview:_sourceLabel];
    
  
    
    
    //3 微博图片
    _imgView = [[ZoomImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imgView];

    //4 背景图片
    _bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
    //设置背景图片拉伸点
    _bgImageView.leftCapWidth = 30;
    _bgImageView.topCapWidth = 30;
    
    //timeline_rt_border_9.png 背景图片
    _bgImageView.imgName = @"timeline_rt_border_9.png";
    //[self addSubview:_bgImageView];
    [self insertSubview:_bgImageView atIndex:0];
    
    
    //5 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    _textLabel.font =   [UIFont systemFontOfSize: FontSize_Weibo(_layoutFrame.isDetail)] ;
    _sourceLabel.font =  [UIFont systemFontOfSize: FontSize_ReWeibo(_layoutFrame.isDetail)] ;
    
    
    WeiboModel *weiboModel = _layoutFrame.weiboModel;
#warning 微博详情 -- 整个frame的x ,y 可能需要在外面设置,这里注释掉
    //设置整个weiboView的frame
    //self.frame = _layoutFrame.frame;
    
    _textLabel.frame = _layoutFrame.textFrame;
    _textLabel.text = weiboModel.text;
    
    
    //是否转发
    if (weiboModel.reWeiboModel != nil) {
        _bgImageView.hidden = NO;
        _sourceLabel.hidden = NO;
        
        //背景图片frame
        _bgImageView.frame = _layoutFrame.bgImageFrame;
        
        //原微博内容以及frame
        _sourceLabel.frame = _layoutFrame.srTextFrame;
        _sourceLabel.text = weiboModel.reWeiboModel.text;
        
        //图片
        NSString *imageUrl = weiboModel.reWeiboModel.thumbnailImage;
        if (imageUrl != nil) {
            _imgView.hidden = NO;
            _imgView.frame = _layoutFrame.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            //大图链接
            _imgView.fullImageUrlString=  weiboModel.reWeiboModel.originalImage;
            
            
            
            
        }else{
            
            _imgView.hidden = YES;
        }
        
    
    }else{//非转发
        //隐藏不用的 view
        _bgImageView.hidden = YES;
        _sourceLabel.hidden = YES;
        
        //图片
        NSString *imageUrl = weiboModel.thumbnailImage;
        if (imageUrl != nil) {
            _imgView.hidden = NO;
            _imgView.frame = _layoutFrame.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            
            _imgView.fullImageUrlString = weiboModel.originalImage;
            
        }else{//没有图片
            
            _imgView.hidden = YES;
        }
    }
    
    //判断是否是gif
    if (_imgView.hidden == NO) {
        NSString *extension;
  
        UIImageView *iconView = _imgView.iconView;
        iconView.frame = CGRectMake(_imgView.width-24, _imgView.height-15, 24, 14);
        //获取url后缀 查看是否是gif
        if (weiboModel.reWeiboModel != nil) {
            extension = [weiboModel.reWeiboModel.thumbnailImage pathExtension];//1239719237912.gif
        }else{
            extension = [weiboModel.thumbnailImage pathExtension];
        }
        
        if ([extension isEqualToString:@"gif"]) {
            iconView.hidden = NO;
            _imgView.isGif = YES;
        }else{
            iconView.hidden = YES;
            _imgView.isGif = NO;
        }

    }
    
    
}





#pragma mark - WXLabelDelegate


//检索文本的正则表达式的字符串
 - (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
 {
        //需要添加链接字符串的正则表达式：@用户、http://、#话题#
       // https://www.baidu.com/hello/jlasjdlf/1.json
        NSString *regex1 = @"@\\w+";
        NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
        NSString *regex3 = @"#\\w+#";
        NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
        return regex;
 }


//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{
    
    return [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    return  [UIColor blueColor];
}


#pragma mark - 主题切换通知
- (void)themeDidChange:(NSNotification *)notification{
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
}



@end
