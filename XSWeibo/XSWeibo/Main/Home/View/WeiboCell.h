//
//  WeiboCell.h
//  XSWeibo
//
//  Created by gj on 15/9/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
#import "WeiboViewLayoutFrame.h"

@interface WeiboCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *srLabel;

@property (strong,nonatomic) WeiboView *weiboView;

@property (strong,nonatomic) WeiboViewLayoutFrame *layoutFrame;




@end
