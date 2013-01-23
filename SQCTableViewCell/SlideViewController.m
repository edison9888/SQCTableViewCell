//
//  SlideViewController.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "SlideViewController.h"

const int viewContentWidth=230;//滑动后停留的x位置
const int viewContentHeight=300;//滑动后停留的y位置
const int viewContentMinOffset=60;//最小的滑动距离，只有超过这个距离才成功，否则会退到原处
const float slideAnimationDuration = 0.8;//滑动成功后的动画执行时间

@interface SlideViewController ()

@end

@implementation SlideViewController
@synthesize topsideView;
@synthesize bottomView;
@synthesize leftController;
@synthesize rightController;

- (id)init
{
    self = [super init];
    if (self) {
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
        [self.view addSubview:bottom];
        self.bottomView = bottom;
        [bottom release];
        
        //创建显示的上面的view，也就是手势的那个view
        UIView *topside = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
        topside.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:topside];
        self.topsideView = topside;
        [topside release];
        
        //左边的controller
        LeftSlideViewController *left = [[LeftSlideViewController alloc] init];
        left.delegate = self;
        self.leftController = left;
        
        [self.leftController initWithController];
        
        //右边的controller
        RightSlideViewController *right = [[RightSlideViewController alloc] init];
        self.rightController = right;
        
        
        //添加成为本控制器的子控制器
        [self addChildViewController:self.leftController];
        self.leftController.view.frame = self.bottomView.bounds;
        [self.bottomView addSubview:self.leftController.view];
        
        //添加成为本控制器的子控制器
        [self addChildViewController:self.rightController];
        self.rightController.view.frame = self.bottomView.bounds;
        [self.bottomView addSubview:self.rightController.view];
        
        //创建滑动的手势，添加到topview上面
        slideGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideTopView:)];
        [self.topsideView addGestureRecognizer:slideGestureReconginzer];
        


    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建底部隐藏的view
 
    //初始化NO，状态是隐藏
    sideViewShowing = NO;
    
    //托动时的初始x坐标
    currentTranslateX = 0;
    
    //托动时的初始y坐标
    currentTranslateY = 0;
    
    //
    currentViewTranslationType = ViewTranslationTypeDefault;
    
    //设置托动view的影子，在四周
    self.topsideView.layer.shadowOffset = CGSizeMake(0, 0);
    self.topsideView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.topsideView.layer.shadowOpacity = 1;
}

- (void)topViewAddTapGestures
{
    //如果有点击的手势就remove掉
    if (clickGestureRecognizer) {
        [self.topsideView  removeGestureRecognizer:clickGestureRecognizer];
        clickGestureRecognizer = nil;
    }
    
    //创建点击的手势，添加的最上面的view上，作用是在分栏的状态的时候点击一下topview就可以恢复
    clickGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(clickOnTopView:)];
    [self.topsideView addGestureRecognizer:clickGestureRecognizer];
}

#pragma mark -
#pragma mark 点击手势的方法    UITapGestureRecognizer
- (void)clickOnTopView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self slideAnimationWithDirection:SlideViewShowDirectionNone duration:slideAnimationDuration];
}
#pragma mark -
#pragma mark 滑动手势的方法    UIPanGestureRecognizer
- (void)slideTopView:(UIPanGestureRecognizer *)gestureRecognizer
{
    //当时手势开始执行时
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        //实时改变topview的位置
        CGFloat translationx = [slideGestureReconginzer translationInView:self.topsideView].x;
        //设置y的坐标
        CGFloat translationy = [slideGestureReconginzer translationInView:self.topsideView].y;
        
        //这里是两种转换模式，第一种是水平的，第二种是有弧度的
        if (currentViewTranslationType == ViewTranslationTypeDefault) {
            self.topsideView.transform = CGAffineTransformMakeTranslation(translationx+currentTranslateX, translationy+currentTranslateY);
            self.topsideView.transform = CGAffineTransformMakeTranslation(translationx+currentTranslateX, 0);

        }else if(currentViewTranslationType == ViewTranslationTypeRotation){
            //计算角度，除以4是因为之前托动的时候变化太，不好看，角度小点显得更加平稳
            self.topsideView.transform = CGAffineTransformMakeRotation((M_PI/180)*translationx/4);
            //改变角度的同时还要改变center的坐标
            self.topsideView.center = CGPointMake(translationx+160, 230);
            
        }
        
        NSLog(@"translation:%f----currentTranslate:%f----translationy:%f",translationx,currentTranslateX,translationy);
        UIView *view ;
        //大于0则是显示显示左边的view，小于0则显示右边的view
        if (translationx+currentTranslateX>0)
        {
            view = self.leftController.view;
        }else
        {
            view = self.rightController.view;
        }
        [self.bottomView bringSubviewToFront:view];
        
	} else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)//当手势结束后会调用
    {
        
		currentTranslateX = self.topsideView.transform.tx;
        currentTranslateY = self.topsideView.transform.ty;
        
        if (!sideViewShowing) {//左边右边controller都没有出现的时候
            //当托动的距离小于最小标准60的时候，松手后就会回到原处
            if (fabs(currentTranslateX)<viewContentMinOffset)
            {
                [self slideAnimationWithDirection:SlideViewShowDirectionNone duration:slideAnimationDuration];
                
            }else if//当当前的坐标大于最小标准的时候显示左边（currentTranslate就是托动结束后停留的那个坐标）
                (currentTranslateX>viewContentMinOffset)
            {
                [self slideAnimationWithDirection:SlideViewShowDirectionLeft duration:slideAnimationDuration];
            }else//当坐标小于的时候说明是负值
            {
                [self slideAnimationWithDirection:SlideViewShowDirectionRight duration:slideAnimationDuration];
            }
        }else//当左边或者右边有一个出现的时候
        {
            //不够标准，松手后还会回到原处
            if (fabs(currentTranslateX)<viewContentWidth-viewContentMinOffset)
            {
                [self slideAnimationWithDirection:SlideViewShowDirectionNone duration:slideAnimationDuration];
                
            }else if//正值说明在左边
                (currentTranslateX>viewContentWidth-viewContentMinOffset)
            {
                
                [self slideAnimationWithDirection:SlideViewShowDirectionLeft duration:slideAnimationDuration];
                
            }else//负值是在右边
            {
                [self slideAnimationWithDirection:SlideViewShowDirectionRight duration:slideAnimationDuration];
            }
        }
        
        
	}


}

#pragma mark -
#pragma mark 动画的方法     nimation
- (void)slideAnimationWithDirection:(SlideViewShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
                //这种情况是在滑动的距离没有达到最小标准的情况下发生的
            case SlideViewShowDirectionNone:
            {
                //回到初始位置（0.0）
                self.topsideView.transform  = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
                //向左滑动显示左边的controller
            case SlideViewShowDirectionLeft:
            {
                //默认的滑动类型，水平滑动
                if (currentViewTranslationType == ViewTranslationTypeDefault) {
                    self.topsideView.transform  = CGAffineTransformMakeTranslation(viewContentWidth, 0);
                    
                }else if//第二种类型，有弧度的滑动
                    (currentViewTranslationType == ViewTranslationTypeRotation){
                        //计算角度
                    self.topsideView.transform = CGAffineTransformMakeRotation((M_PI / 180.0) * 10.0f);
                        //还要重设一下它的中心位置，如果不射会遮住底部的controller
                    self.topsideView.center = CGPointMake(300, 260);
                }
                
            }
                break;
                //向右边滑动，显示右边的controller
            case SlideViewShowDirectionRight:
            {
                self.topsideView.transform  = CGAffineTransformMakeTranslation(-viewContentWidth, 0);
            }
                break;
            default:
                break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished) {
        //动画结束后view设置为可交互
        self.topsideView.userInteractionEnabled = YES;
        self.bottomView.userInteractionEnabled = YES;
        
        if (direction == SlideViewShowDirectionNone) {
            //如果没有达到最小标准则remove点击的手势
            if (clickGestureRecognizer) {
                [self.topsideView removeGestureRecognizer:clickGestureRecognizer];
                clickGestureRecognizer = nil;
            }
            sideViewShowing = NO;
            
        }else
        {
            //滑动成功后添加点击的手势
            [self topViewAddTapGestures];
            sideViewShowing = YES;
        }
        //纪录下当前的状态
        currentTranslateX = self.topsideView.transform.tx;
        currentTranslateY = self.topsideView.transform.ty;
        
	};
    //当动画开始设置view为不可交互
    self.topsideView.userInteractionEnabled = NO;
    self.bottomView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}


#pragma mark -
#pragma mark UINavgationController的delegate方法
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果当前的controller发生了push的操作，则remove滑动的手势，
    if ([navigationController.viewControllers count]>1) {
        [self removepanGestureReconginzerWhilePushed:YES];
    }else
    {
        [self removepanGestureReconginzerWhilePushed:NO];
    }
    
}

- (void)removepanGestureReconginzerWhilePushed:(BOOL)push
{
    //如果navgation的viewcontroller数量大于1说明进行了push操作，要remove手势，等于1则添加手势
    if (push) {
        if (slideGestureReconginzer) {
            [self.topsideView removeGestureRecognizer:slideGestureReconginzer];
            slideGestureReconginzer = nil;
        }
    }else
    {
        if (!slideGestureReconginzer) {
            slideGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideTopView:)];
            [self.topsideView addGestureRecognizer:slideGestureReconginzer];
        }
    }
}

#pragma mark -
#pragma mark SlideControllerSelectDelegate method
- (void)leftSelectMethod:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller setDelegate:self];
    }
    //如果当前的控制器不存在则把传过来的控制器赋给当前并且添加到self的child里面（在程序刚刚启动的时候会发生）
    if (currentViewController == nil) {
		controller.view.frame = self.topsideView.bounds;
		currentViewController = controller;
		[self addChildViewController:currentViewController];
		[self.topsideView addSubview:currentViewController.view];
		[currentViewController didMoveToParentViewController:self];
        
	} else if   //如果点击的和当前的不一样，则进行controller的切换
        (currentViewController != controller && controller !=nil)
    {
		controller.view.frame = self.topsideView.bounds;
        
        //准备开始切换
		[currentViewController willMoveToParentViewController:nil];
        
        //把点击的那个controller加入到本控制器的child中取
		[self addChildViewController:controller];
        
        //当前view 不能交互
		self.view.userInteractionEnabled = NO;
        
		[self transitionFromViewController:currentViewController   //当前的controller
						  toViewController:controller              //将要跳转的controller
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
                                    //切换完成后设置view为可交互
									self.view.userInteractionEnabled = YES;
                                    //把原来的remove掉
									[currentViewController removeFromParentViewController];
									[controller didMoveToParentViewController:self];
                                    //设置点击的controller为当前的controller
									currentViewController = controller;
								}
         ];
        
	}
    //controller切换完成后，恢复到默认的状态
    [self showSlideControllerWithDirection:SlideViewShowDirectionNone];
}

//右边controller的delegate方法，暂时先留着
- (void)rightSelectMethod:(UIViewController *)controller
{

}

//这个delegate的方法主要用在navgationitem上的按钮点击方法，leftbarbuttonitem点击后呈现分栏状态，造成滑动的效果
- (void)showSlideControllerWithDirection:(SlideViewShowDirection)direction
{
    //点击左边或者点击右边
    if (direction!=SlideViewShowDirectionNone) {
        UIView *view ;
        if (direction == SlideViewShowDirectionLeft)
        {
            view = self.leftController.view;
        }else
        {
            view = self.rightController.view;
        }
        [self.bottomView bringSubviewToFront:view];
    }
    [self slideAnimationWithDirection:direction duration:slideAnimationDuration];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
