//
//  RightSlideViewController.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "RightSlideViewController.h"

@interface RightSlideViewController ()

@end

@implementation RightSlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    bar.barStyle = UIBarStyleDefault;
    
    [self.view addSubview:bar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
