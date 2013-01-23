//
//  PhoneNumberObject.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneNumberObject : NSObject

/**
 以下四个属性都是只读，只能在初始化的时候赋值
 
 str_number：查询的电话号码
 str_province：号码归属地中的省份信息
 str_city：号码归属地中的城市信息
 str_cardType：手机卡类型信息
 
 */
@property (readonly) NSString *numberString;
@property (readonly) NSString *provinceString;
@property (readonly) NSString *cityString;
@property (readonly) NSString *cardTypeString;

- (id)initWithAttributes:(id)attributes;

@end
