//
//  DataSource.h
//  SQCTableViewCell
//
//  Created by sun qichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneNumberObject.h"
#import "WeatherInfoObject.h"
#define PARSEFAILED @"解析xml的时候报错"
#define NOTINCLUDE @"没有此号码记录"
#define KEY_NUMBER @"number"
#define KEY_PROVINCE @"province"
#define KEY_CITY @"city"
#define KEY_CARDTYPE @"cardType"
#define PHONEPARSEELEMENT @"getMobileCodeInfoResult"
#define WEATHERPARSEELEMENT @"getWeatherResult"

/**
 使用的时候查询的方法，传进去手机号，例如：
 [DataSource findPhoneNumbers:_numberTextField.text
 resultBlock:^(FindNumberDataSource *dataSource) {
 
    PhoneNumberObject有四个属性：
        str_number：查询的电话号码
        str_province：号码归属地中的省份信息
        str_city：号码归属地中的城市信息
        str_cardType：手机卡类型信息
 
 } failedBlock:^(NSString *error) {
 NSLog(@"%@",error);
 
 }];
 
 */
@interface DataSource : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>
{
    //用来解析响应回来的xml
    NSXMLParser *xmlParser;
    
    //接收的结果
    NSMutableString *soapResults;
    
    //是否找到了标签
    BOOL elementFound;
}
typedef void (^findResultBlock)(id dataSource);
typedef void (^failedBlock)(NSString *error);

@property (copy) failedBlock failedB;

@property (nonatomic ,retain) NSString *elementString;

@property (nonatomic ,retain) PhoneNumberObject *phoneData;
/**
 @param 要查询的手机号码
 @return 返回一个block，其中PhoneNumberObject有四个属性：1.手机号码。2.省份。3.城市。4.手机卡类型
 */
+ (void)findPhoneNumbers:(NSString *)numbers
             resultBlock:(findResultBlock)block
             failedBlock:(failedBlock)failed;

@property (nonatomic ,retain) WeatherInfoObject *weatherData;

/**
 @param 要查询的城市
 @return 返回一个block，其中WeatherInfoObject中包括如下内容：
 1.城市。2.日期。3.天气。4.穿衣指数。5.近5天的天气
 */
+ (void)findWeatherInfo:(NSString *)city
             resultBlock:(findResultBlock)block
             failedBlock:(failedBlock)failed;








@end






