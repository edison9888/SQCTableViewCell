//
//  WeatherInfoObject.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "WeatherInfoObject.h"

@implementation WeatherInfoObject
@synthesize weatherInfoString = selfWeatherInfoString;

- (id)initWithAttributes:(id)attributes {
    self = [super init];
    if (self) {
        NSString *content = (NSString *)attributes;
        
        selfWeatherInfoString = content;
        NSLog(@"%@",selfWeatherInfoString);
    }
    
    return self;
}

@end
