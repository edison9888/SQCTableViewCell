//
//  NetWorking.h
//  SQCTableViewCell
//
//  Created by sun qichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^receiveSuccessful)(id data);
typedef void (^receiveFailed)(id error);

@interface NetWorking : NSObject
{
    //发起请求的connection
    NSURLConnection *connectionNet;
    
}
//用来接受网络传过来的数据
@property (nonatomic ,retain) NSMutableData *receiveData;

@property (copy) receiveSuccessful succeedB_net;
@property (copy) receiveFailed failedB_net;


/**
 
 传进来需要查询的手机号码，等待接收成功后会返回查询结果的NSMutableData类型的数据，
 这里用作id类型，再接收的时候用再转化为NSMutableData即可
 NSMutableData里面是xml的代码，需要解析后才能获得信息

 @param 要查询的手机号码
 
 @return 成功则返回NSMutableData，里面是xml结构的数据，
         包括：1.手机号码。2.省份。3.城市。4.手机卡类型
 
 @return 失败则返回失败的信息
 */
+ (void)inquiryNumber:(NSString *)numbers
          resultBlock:(receiveSuccessful)resultBlock
          failedBlock:(receiveFailed)failed;

/**
 
 传进来需要查询的城市，等待接收成功后会返回查询结果的NSMutableData类型的数据，
 这里用作id类型，再接收的时候用再转化为NSMutableData即可
 NSMutableData里面是xml的代码，需要解析后才能获得信息
 
 @param 要查询的城市
 
 @return 成功则返回NSMutableData，里面是xml结构的数据，
 包括：1.城市。2.日期。3.天气。4.穿衣指数。5.近5天的天气
 
 @return 失败则返回失败的信息
 */
+ (void)inquiryWeather:(NSString *)city
          resultBlock:(receiveSuccessful)resultBlock
          failedBlock:(receiveFailed)failed;

@end
