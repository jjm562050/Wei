//
//  NearByViewController.m
//  XSWeibo
//
//  Created by gj on 15/9/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "NearByViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "DataService.h"
#import "WeiboModel.h"
#import "DetailViewController.h"


/**
 *  1 定义(遵循MKAnnotation协议 )annotation类
    2 创建 annotation对象，并且把对象加到mapView;
    3 实现mapView 的协议方法 ,创建标注视图
 */


@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createViews];
    [self _location];
    
    //往mapView中添加annotation
    
//    WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
//    annotation.title = @"汇文教育";
//    annotation.subtitle = @"xs23班测试";
//    CLLocationCoordinate2D coordinate = {30.2042,120.2019};
//    [annotation setCoordinate:coordinate];
//    [_mapView addAnnotation:annotation];
//    
//    
//    WeiboAnnotation *annotation1 = [[WeiboAnnotation alloc] init];
//    annotation1.title = @"汇文教育aa";
//    annotation1.subtitle = @"xs23班测试aa ";
//    CLLocationCoordinate2D coordinate1 = {30.1942,120.2119};
//    [annotation1 setCoordinate:coordinate1];
//    [_mapView addAnnotation:annotation1];
    

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark mapView 及 代理
- (void)_createViews{
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //地图显示类型 ： 标准、卫星 、混合
    _mapView.mapType = MKMapTypeStandard;
    
    //设置代理
    _mapView.delegate = self;
    
    //用户跟踪模式
   // _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    [self.view addSubview:_mapView];

}

#pragma mark - mapView代理
/**
 *  mapView位置更新后被调用
 */
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    
//    
//    CLLocation *location = [userLocation location];
//    CLLocationCoordinate2D    coordinate = [location coordinate];
//    
//    NSLog(@"纬度  %lf,精度 %lf",coordinate.latitude,coordinate.longitude);
//    
//    
//
//    
//}


//标注视图北选中
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    
    WeiboAnnotation *weiboAnnotation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = weiboAnnotation.weiboModel;
    
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.weiboModel = weiboModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}


//返回标注视图
//二 自定义标注视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
  //如果是用户定位则用默认的标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    //复用池，获取标注视图
    if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
        WeiboAnnotationView *annotationView = (WeiboAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (annotationView == nil) {

            annotationView = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];

        }
        annotationView.annotation = annotation;
        return annotationView;
    }
    
    
    return nil;

}


//一  用大头针显示
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
//  //如果是用户定位则用默认的标注视图
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    
//    //复用池，获取标注视图
//    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//    if (pinView == nil) {
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
//        
//        //1 设置大头这颜色
//        pinView.pinColor = MKPinAnnotationColorGreen;
//        //2 设置从天而降的效果
//        pinView.animatesDrop = YES;
//        //3 设置显示标题
//        pinView.canShowCallout = YES;
//        //设置辅助视图
//        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        
//    }
//    
//    return pinView;
//}
//



#pragma mark - 定位管理
- (void)_location{
    _locationManager = [[CLLocationManager alloc] init];
    
    if (kVersion > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy =  kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //1 停止定位
    [_locationManager stopUpdatingLocation];
    
    //2 请求数据
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self _loadNearByData:lon lat:lat];
    
    //3 设置地图显示区域
//    typedef struct {
//        CLLocationDegrees latitudeDelta;
//        CLLocationDegrees longitudeDelta;
//    } MKCoordinateSpan;
//    
//    typedef struct {
//        CLLocationCoordinate2D center;
//        MKCoordinateSpan span;
//    } MKCoordinateRegion;
    
    
    //>>01 设置 center
    
    CLLocationCoordinate2D  center = coordinate;
    
    //>>02 设置span ,数值越小,精度越高，范围越小
    
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
}


//获取附近微博
- (void)_loadNearByData:(NSString *)lon lat:(NSString *)lat{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    

    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSMutableArray *annotationArray = [[ NSMutableArray alloc] initWithCapacity:statuses.count];
        
        
        for (NSDictionary *dataDic in statuses) {
            
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
        
            //创建annotation
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
            annotation.weiboModel = model;
            [annotationArray addObject:annotation];
            
        }
          //把annotation 添加到mapView
        [_mapView addAnnotations:annotationArray];
      

    }];

    
}

@end
