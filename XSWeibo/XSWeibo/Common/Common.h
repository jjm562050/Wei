//
//  Common.h
//  XSWeibo
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#ifndef XSWeibo_Common_h
#define XSWeibo_Common_h



#define kVersion   [[UIDevice currentDevice].systemVersion doubleValue]

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

//登录
#define kAppKey             @"1146805410"
#define kAppSecret          @"78157bedd65e5a2c1c772ac34b69ccb4"
#define kAppRedirectURI     @"http://www.baidu.com"

#define unread_count @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments  @"comments/show.json"   //评论列表
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态







//微博字体
#define FontSize_Weibo(isDetail) isDetail?16:15  //微博字体
#define FontSize_ReWeibo(isDetail) isDetail?15:14 //转发微博字体

#endif
