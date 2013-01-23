//
//  LeftSlideViewController.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SlideControllerSelectDelegate;
@interface LeftSlideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic ,retain) UITableView *functionTableView;
@property (nonatomic ,assign) id<SlideControllerSelectDelegate>delegate;
@property (nonatomic ,retain) NSMutableArray *dataArray;
@property (nonatomic ,assign) int selectIndex;

- (void)initWithController;
@end
