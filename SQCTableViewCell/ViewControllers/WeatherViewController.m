//
//  WeatherViewController.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize textView = selfTextView;
@synthesize contentString = selfContentString;
@synthesize textFieldCity = selfTextFieldCity;
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"weather";
        UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        bar.barStyle = UIBarStyleDefault;
        
        [self.view addSubview:bar];
        //查询的输入框
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 60.0f, 200.0f, 30.0f)];
        field.backgroundColor = [UIColor grayColor];
        field.textColor = [UIColor whiteColor];
        field.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:field];
        self.textFieldCity = field;
        //显示查询内容的textview
        UITextView *temp_textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 100.0f, 300.0f, 330.0f)];
        temp_textView.backgroundColor = [UIColor whiteColor];
        temp_textView.editable = NO;
        [self.view addSubview:temp_textView];
        self.textView = temp_textView;
        
        UIButton *tempInquiryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [tempInquiryButton setFrame:CGRectMake(230.0f, 60.0f, 80.0f, 30.0f)];
        [tempInquiryButton setTitle:@"cha" forState:UIControlStateNormal];
        [tempInquiryButton addTarget:self action:@selector(findWeatherInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempInquiryButton];
        
        //右上角的查询按钮
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(findWeatherInfo:)];
        self.navigationItem.rightBarButtonItem = right;
        
    }
    return self;
}

- (void)findWeatherInfo:(id)sender
{
    //不能为空
    NSString *textCity = selfTextFieldCity.text;
    if (!selfTextFieldCity.text) {
        NSLog(@"sorry.");
    }else{
        [selfTextFieldCity resignFirstResponder];
        [DataSource findWeatherInfo:textCity resultBlock:^(id dataSource) {
            WeatherInfoObject *weatherInfo = (WeatherInfoObject *)dataSource;
            self.contentString = weatherInfo.weatherInfoString;
        } failedBlock:^(NSString *error) {
            NSLog(@"%@",error);
        }];
    }
    
}

//set方法会自动调用
- (void)setContentString:(NSString *)contentString
{
    selfContentString = contentString;
    selfTextView.text = selfContentString;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
