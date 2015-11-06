//
//  LeftViewController.h
//  XSWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LeftViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_sectionTitles;
    NSArray *_rowTitles;

}

@end
