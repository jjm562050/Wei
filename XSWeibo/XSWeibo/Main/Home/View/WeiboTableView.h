//
//  WeiboTableView.h
//  XSWeibo
//
//  Created by gj on 15/9/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewLayoutFrame.h"
@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong) NSArray  *layoutFrameArray;


@end
