//
//  NearByViewController.h
//  XSWeibo
//
//  Created by gj on 15/9/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface NearByViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>{
    
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    
}

@end
