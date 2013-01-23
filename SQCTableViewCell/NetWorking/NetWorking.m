//
//  NetWorking.m
//  SQCTableViewCell
//
//  Created by sun qichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "NetWorking.h"
/**
 拼接xml的代码，是网上公开的webservice的服务功能，
 可以免费查询，但是信息有限，目前只能查手机号码的归属地，包括
 省份，城市和手机卡类型 
 
 mobileCode里面需要传如要查询的手机号码
 userID需要传入用户的id，由于是免费用户所以传@“”
 
 本服务对应的地址是 http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx
 */
#define PHONEHTTPBODY(number,user) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\"><mobileCode>%@</mobileCode><userID>%@</userID></getMobileCodeInfo></soap12:Body></soap12:Envelope>",number,user]

//归属地对应的请求地址
#define PHONEWEBSERVICEURL @"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx"

/**
 拼接xml的代码，是网上公开的webservice的服务功能，
 可以免费查询，但是信息有限，城市的天气信息
 
 theCityCode里面需要传如要查询的城市
 userID需要传入用户的id，由于是免费用户所以传@“”
 
 本服务对应的地址是 http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx
 */
#define WEATHERHTTPBODY(city,user) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><getWeather xmlns=\"http://WebXml.com.cn/\"><theCityCode>%@</theCityCode><theUserID>%@</theUserID></getWeather></soap12:Body></soap12:Envelope>",city,user]

//查询天气对应的请求地址
#define WEATHERWEBSERVICEURL @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx"

//设置httpheader的value
#define CONTENTTYPE @"application/soap+xml; charset=utf-8"

//下面是发生错时的提示信息
#define CONNECTIONFAILED @"创建connection的时候失败"
#define REVEIVEFAILED @"接收数据时报错"
#define PARSEFAILED @"解析xml的时候报错"
#define NOTINCLUDE @"没有此号码记录"

@implementation NetWorking
@synthesize receiveData = _receiveData;

- (id)initWithConnectionhttpBody:(NSString *)body serviceURL:(NSString *)URL
{
    self = [super init];
    if (self) {
        //接收数据的data
        _receiveData = nil;
        connectionNet = nil;
        //首先设置请求的xml内容的body
        NSString *httpBody = body;
        
        //创建webservice的地址
        NSURL *url = [NSURL URLWithString:URL];
        
        //创建request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //获得httpbody的长度
        NSString *httpBodyLength = [NSString stringWithFormat:@"%d",[httpBody length]];
        
        //设置request的内容
        [request addValue:CONTENTTYPE forHTTPHeaderField:@"Content-Type"];
        [request addValue:httpBodyLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[httpBody dataUsingEncoding:NSUTF8StringEncoding]];
        //创建connection
        connectionNet = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (connectionNet) {
            NSMutableData *mdata = [[NSMutableData alloc] init];
            self.receiveData = mdata;
        }else{
            self.failedB_net(CONNECTIONFAILED);
        }
    }
    return self;
}

#pragma mark -
#pragma mark 根据手机号码，创建connection
+ (void)inquiryNumber:(NSString *)numbers
          resultBlock:(receiveSuccessful)resultBlock
          failedBlock:(receiveFailed)failed
{
    NetWorking *net = [[NetWorking alloc] initWithConnectionhttpBody:PHONEHTTPBODY(numbers, @"") serviceURL:PHONEWEBSERVICEURL];
    net.succeedB_net = resultBlock;
    net.failedB_net = failed;
    
}


#pragma mark -
#pragma mark 根据城市来查询天气
+ (void)inquiryWeather:(NSString *)city
           resultBlock:(receiveSuccessful)resultBlock
           failedBlock:(receiveFailed)failed
{
    NetWorking *net = [[NetWorking alloc] initWithConnectionhttpBody:WEATHERHTTPBODY(city, @"") serviceURL:WEATHERWEBSERVICEURL];
    net.succeedB_net = resultBlock;
    net.failedB_net = failed;
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods
// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [self.receiveData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [self.receiveData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    if (connectionNet) {
        connectionNet = nil;

    }
    if (self.receiveData) {
        self.receiveData = nil;

    }
    self.failedB_net(REVEIVEFAILED);
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    self.succeedB_net(_receiveData);
}


@end
