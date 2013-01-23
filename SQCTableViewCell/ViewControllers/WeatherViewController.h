//
//  WeatherViewController.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
@interface WeatherViewController : UIViewController


@property (nonatomic ,retain) UITextView *textView;
@property (nonatomic ,retain) UITextField *textFieldCity;
@property (nonatomic ,copy) NSString *contentString;
@end
