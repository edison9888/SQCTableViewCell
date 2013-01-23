//
//  DataSource.m
//  SQCTableViewCell
//
//  Created by sun qichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "DataSource.h"
#import "NetWorking.h"

@implementation DataSource
@synthesize phoneData = selfPhoneData;
@synthesize weatherData = selfWeatherData;
@synthesize elementString = selfElementString;
- (id)initWithAttributes:(id)attributes element:(NSString *)element{
    self = [super init];
    if (self) {
        self.elementString = element;
        NSMutableData *recevieData_ = (NSMutableData *)attributes;
        if (recevieData_) {
            // 使用NSXMLParser解析出我们想要的结果
            xmlParser = [[NSXMLParser alloc] initWithData: recevieData_];
            [xmlParser setDelegate: self];
            [xmlParser setShouldResolveExternalEntities: YES];
            [xmlParser parse];
        }
        
    }
    
    return self;
}


#pragma mark -
#pragma mark 获取手机号码归属地的方法
+ (void)findPhoneNumbers:(NSString *)numbers
             resultBlock:(findResultBlock)block
             failedBlock:(failedBlock)failed;
{
    [NetWorking  inquiryNumber:numbers resultBlock:^(id data) {
        DataSource *dataSource = [[DataSource alloc] initWithAttributes:data element:PHONEPARSEELEMENT];
        dataSource.failedB = failed;
        
        block(dataSource.phoneData);
        
    } failedBlock:^(id error) {
        NSLog(@"%@",(NSString *)error);
        
    }];
    

}

#pragma mark -
#pragma mark 获取天气信息的方法
+ (void)findWeatherInfo:(NSString *)city
            resultBlock:(findResultBlock)block
            failedBlock:(failedBlock)failed
{
    [NetWorking  inquiryWeather:city resultBlock:^(id data) {
        DataSource *dataSource = [[DataSource alloc] initWithAttributes:data element:WEATHERPARSEELEMENT];
        dataSource.failedB = failed;
        
        block(dataSource.weatherData);
        
    } failedBlock:^(id error) {
        NSLog(@"%@",(NSString *)error);
        
    }];

    
}
#pragma mark -
#pragma mark XML Parser Delegate Methods
// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:selfElementString]) {
        if (!soapResults) {
            soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
    
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        [soapResults appendString: string];
    }
    
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:selfElementString]) {
        if ([soapResults isEqualToString:NOTINCLUDE]) {
            self.failedB(NOTINCLUDE);
        }else{
            if ([selfElementString isEqualToString:PHONEPARSEELEMENT]) {
                PhoneNumberObject *phoneObject = [[PhoneNumberObject alloc] initWithAttributes:soapResults];
                self.phoneData = phoneObject;
            }
            
            if ([selfElementString isEqualToString:WEATHERPARSEELEMENT]) {
                WeatherInfoObject *phoneObject = [[WeatherInfoObject alloc] initWithAttributes:soapResults];
                self.weatherData = phoneObject;
            }
            
            elementFound = FALSE;
            // 强制放弃解析
            [xmlParser abortParsing];
        }
            
    }
}


// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (soapResults) {
        soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
    self.failedB(PARSEFAILED);
}


@end
