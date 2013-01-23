//
//  PhoneNumberObject.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "PhoneNumberObject.h"

@implementation PhoneNumberObject
@synthesize numberString = selfNumberString;
@synthesize provinceString = selfProvinceString;
@synthesize cityString = selfCityString;
@synthesize cardTypeString = selfCardString;

- (id)initWithAttributes:(id)attributes {
    self = [super init];
    if (self) {
        NSString *contentString = (NSString *)attributes;
        NSString *number = @"";
        NSString *province = @"省份：";
        NSString *city = @"城市：";
        NSString *type = @"手机卡类型：";
        /**
         由于返回的是一整串字符串，所以需要进一步切分,原文是：
         <string xmlns="http://WebXml.com.cn/">15021944855：上海 上海 上海移动全球通卡</string>
         
         第一步：以'：'分割成一个数组array，第一个值是手机号，第二个值是归属地信息
         第二步：取array的第二个值，以' '分割成一个数组，第一个值是省份，第二个值是城市，第三个值是卡类型信息
         
         */
        NSArray *arr = [contentString componentsSeparatedByString:@"："];
        NSString *two = @"";
        /**
         如果是报错的情况就不拆分了
         */
        if ([arr count]>1) {
            number = [number stringByAppendingFormat:@"%@",[arr objectAtIndex:0]];
            two = [arr objectAtIndex:1];
        }
        NSArray *arr_two = [two componentsSeparatedByString:@" "];
        
        //等于1的情况是因为免费的用户一天只能查100次，超过后就返回超过数量的信息
        if ([arr_two count]==1) {
            selfNumberString = number;
            selfProvinceString = province;
            selfCityString = city;
            selfCardString = contentString;
            
        }else{
            province = [province stringByAppendingFormat:@"%@",[arr_two objectAtIndex:0]];
            city = [city stringByAppendingFormat:@"%@",[arr_two objectAtIndex:1]];
            type = [type stringByAppendingFormat:@"%@",[arr_two objectAtIndex:2]];
            selfNumberString = number;
            selfProvinceString = province;
            selfCityString = city;
            selfCardString = type;
        }
    }
    
    return self;
}

@end
