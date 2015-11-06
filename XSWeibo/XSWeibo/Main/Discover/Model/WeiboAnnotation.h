//
//  WeiboAnnotation.h
//  XSWeibo
//
//  Created by gj on 15/9/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "WeiboModel.h"

@interface WeiboAnnotation : NSObject<MKAnnotation>
// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property (nonatomic,strong) WeiboModel *weiboModel;



@end
