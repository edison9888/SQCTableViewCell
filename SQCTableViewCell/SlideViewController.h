//
//  SlideViewController.h
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "RightSlideViewController.h"
#import <QuartzCore/QuartzCore.h>

typedef enum SlideViewShowDirection
{
    SlideViewShowDirectionNone = 0,
    SlideViewShowDirectionLeft = 1,
    SlideViewShowDirectionRight = 2
}SlideViewShowDirection;

typedef enum ViewTranslationType
{
    ViewTranslationTypeDefault = 0,
    ViewTranslationTypeRotation = 1
    
}ViewTranslationType;

@protocol SlideControllerSelectDelegate <NSObject>


- (void)leftSelectMethod:(UIViewController *)controller;
- (void)rightSelectMethod:(UIViewController *)controller;
- (void)showSlideControllerWithDirection:(SlideViewShowDirection)direction;

@end

@interface SlideViewController : UIViewController<SlideControllerSelectDelegate,UINavigationControllerDelegate>
{
    //当前显示的那个的控制器
    UIViewController *currentViewController;
    
    //点击的手势
    UITapGestureRecognizer *clickGestureRecognizer;
    
    //滑动的手势
    UIPanGestureRecognizer *slideGestureReconginzer;
    
    //是否处于分栏状态
    BOOL sideViewShowing;
    
    //当前滑动时的x坐标
    CGFloat currentTranslateX;
    
    //当前滑动时的y坐标
    CGFloat currentTranslateY;
    
    //用手滑动时的类型，目前写了两个，一个是水平滑动的，另一个是旋转滑动的
    ViewTranslationType currentViewTranslationType;

}
//显示在最上面的view
@property (nonatomic ,retain) UIView *topsideView;
//隐藏在下面的view，滑开topsideView后可以看到
@property (nonatomic ,retain) UIView *bottomView;
//左边的controller
@property (nonatomic ,retain) LeftSlideViewController *leftController;
//右边的controller
@property (nonatomic ,retain) RightSlideViewController *rightController;




@end
