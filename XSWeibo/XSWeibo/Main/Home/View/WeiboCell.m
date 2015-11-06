//
//  WeiboCell.m
//  XSWeibo
//
//  Created by gj on 15/9/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"



@implementation WeiboCell

- (void)awakeFromNib {
    //创建微博内容View
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.backgroundColor = [UIColor clearColor];
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    _weiboView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_weiboView];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
    
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //00 获取微博 model
    WeiboModel *_model = _layoutFrame.weiboModel;
    
    
    //01 用户头像
    
    NSString *urlStr = _model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    
    //02 用户昵称
    _nickNameLabel.text = _model.userModel.screen_name;
    
    //03 评论数 转发数
    _rePostLabel.text = [NSString stringWithFormat:@"转发:%@",_model.repostsCount];//_model.repostsCount;

    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",_model.commentsCount];
    
    //04 微博来源
    _srLabel.text = _model.source;
    
    
    //05 微博内容
    _weiboView.layoutFrame = _layoutFrame;
    
#warning 微博详情：整个weiboView的 x y 在这里设置
    _weiboView.frame = _layoutFrame.frame;

    
}


@end
