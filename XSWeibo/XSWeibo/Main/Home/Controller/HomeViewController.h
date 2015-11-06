//
//  HomeViewController.h
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeiboRequest.h"
#import "WeiboTableView.h"
@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate>{
    WeiboTableView *_weiboTable;
}


@end
