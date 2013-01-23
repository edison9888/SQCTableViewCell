//
//  MainViewTableViewCell.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#define KEY_CELLINDEX @"cellIndex"
#define KEY_CELLPHONENUMBER @"cellPhoneNumber"
#define KEY_CELLPROVINCE @"cellProvince"
#define KEY_CELLCITY @"cellCity"
#define KEY_CELLCARDTYPE @"cellCardType"
@protocol MainViewTableViewCellDelegate <NSObject>

@optional
/**
    点击查询按钮后回调的函数
    
 */
- (void)phoneNumberFindMethod:(id)sender;

@end
@interface MainViewTableViewCell : UITableViewCell

@property (nonatomic ,assign) id<MainViewTableViewCellDelegate>delegate;
/**
 DataSource：这个数据对象包括4个只读属性 
 
    str_number：查询的电话号码
    str_province：号码归属地中的省份信息
    str_city：号码归属地中的城市信息
    str_cardType：手机卡类型信息
 
 */
@property (nonatomic ,retain) PhoneNumberObject *numberData;
/**
 第一个的数据data是在没有点击查询按钮的时候创建的，
 
 @"15021944855",KEY_CELLPHONENUMBER,
 @"省份：",KEY_CELLPROVINCE,
 @"城市：",KEY_CELLCITY,
 @"手机卡类型：",KEY_CELLCARDTYPE,
 [NSString stringWithFormat:@"%d",i],KEY_CELLINDEX,nil];
 
 */
@property (nonatomic ,retain) NSDictionary *data;

@property (nonatomic ,retain) UILabel *label_number;
@property (nonatomic ,retain) UILabel *label_phoneNumber;
@property (nonatomic ,retain) UILabel *label_province;
@property (nonatomic ,retain) UILabel *label_city;
@property (nonatomic ,retain) UILabel *label_cardType;
@property (nonatomic ,retain) UIButton *btn_find;

@end
