//
//  WeatherInfoObject.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherInfoObject : NSObject
/**
 所有天气信息的内容
 */
@property (nonatomic ,copy) NSString *weatherInfoString;
- (id)initWithAttributes:(id)attributes;
@end
