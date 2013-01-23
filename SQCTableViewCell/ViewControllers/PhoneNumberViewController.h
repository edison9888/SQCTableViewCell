//
//  PhoneNumberViewController.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
@interface PhoneNumberViewController : UIViewController

@property (nonatomic ,retain) UILabel *numberLabel;
@property (nonatomic ,retain) UILabel *provinceLabel;
@property (nonatomic ,retain) UILabel *cityLabel;
@property (nonatomic ,retain) UILabel *cardTypeLabel;
@property (nonatomic ,retain) UITextField *numberTextField;
@property (nonatomic ,retain) UIButton *inquiryButton;

/**
 这个是针对一个cell的数据源
 DataSource：这个数据对象包括4个只读属性
 
 str_number：查询的电话号码
 str_province：号码归属地中的省份信息
 str_city：号码归属地中的城市信息
 str_cardType：手机卡类型信息
 */
@property (nonatomic ,retain) PhoneNumberObject *numberData;
@end
