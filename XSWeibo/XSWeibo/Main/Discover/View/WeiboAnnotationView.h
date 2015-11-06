//
//  WeiboAnnotationView.h
//  XSWeibo
//
//  Created by gj on 15/9/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView{
    UIImageView *_headImageView;//头像视图 
    UILabel *_textLabel; //微博内容
    
}

@end
