//
//  MainViewController.h
//  SQCTableViewCell
//
//  Created by sun qichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "MainViewTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MainViewTableViewCellDelegate>

@property (nonatomic ,retain) UITableView *tableView;
/**
 这个是针对一个cell的数据源
 DataSource：这个数据对象包括4个只读属性
 
 str_number：查询的电话号码
 str_province：号码归属地中的省份信息
 str_city：号码归属地中的城市信息
 str_cardType：手机卡类型信息
 */
@property (nonatomic ,retain) PhoneNumberObject *numberData;
/**
 针对tableview的所有数据源，在初始化的时候创建
 */
@property (nonatomic ,retain) NSMutableArray *tableViewData;
@end
