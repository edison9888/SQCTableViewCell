//
//  PhoneNumberViewController.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "PhoneNumberViewController.h"

#define LABELFONT 18   //label的字体
#define STARTX 10      //label的初始x坐标
#define STARTY 10      //label的初始y坐标
#define SPACE 5       //间隔的距离
#define LABELWIDTH 300 //label的宽度
#define LABELHEITHG 30 //label的高度

@interface PhoneNumberViewController ()

@end

@implementation PhoneNumberViewController
@synthesize numberLabel = selfNumberLabel;
@synthesize provinceLabel = selfProvinceLabel;
@synthesize cityLabel = selfCityLabel;
@synthesize cardTypeLabel = selfCardTypeLabel;
@synthesize numberTextField = selfNumberTextField;
@synthesize inquiryButton = selfInquiryButton;
@synthesize numberData = selfNumberData;

- (id)init
{
    self = [super init];
    if (self) {
        UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        bar.barStyle = UIBarStyleDefault;
        
        [self.view addSubview:bar];
        
        //显示手机号码
        UILabel *tempNumber = [[UILabel alloc] initWithFrame:CGRectZero];
		tempNumber.backgroundColor = [UIColor clearColor];
		tempNumber.textColor = [UIColor blackColor];
        tempNumber.textAlignment = NSTextAlignmentLeft;
		tempNumber.font = [UIFont systemFontOfSize:LABELFONT];
		[self.view addSubview:tempNumber];
		self.numberLabel = tempNumber;
		[tempNumber release];
        
        //显示省份
        UILabel *tempProvince = [[UILabel alloc] initWithFrame:CGRectZero];
		tempProvince.backgroundColor = [UIColor clearColor];
		tempProvince.textColor = [UIColor blackColor];
        tempProvince.textAlignment = NSTextAlignmentLeft;
		tempProvince.font = [UIFont systemFontOfSize:LABELFONT];
		[self.view addSubview:tempProvince];
		self.provinceLabel = tempProvince;
		[tempProvince release];
        
        //显示城市
        UILabel *tempCity = [[UILabel alloc] initWithFrame:CGRectZero];
		tempCity.backgroundColor = [UIColor clearColor];
		tempCity.textColor = [UIColor blackColor];
        tempCity.textAlignment = NSTextAlignmentLeft;
		tempCity.font = [UIFont systemFontOfSize:LABELFONT];
		[self.view addSubview:tempCity];
		self.cityLabel = tempCity;
		[tempCity release];
        
        //显示手机卡类型
        UILabel *tempCardType = [[UILabel alloc] initWithFrame:CGRectZero];
		tempCardType.backgroundColor = [UIColor clearColor];
		tempCardType.textColor = [UIColor blackColor];
        tempCardType.textAlignment = NSTextAlignmentLeft;
		tempCardType.font = [UIFont systemFontOfSize:LABELFONT];
		[self.view addSubview:tempCardType];
		self.cardTypeLabel = tempCardType;
		[tempCardType release];
        
        //输入手机号码的textfield
        UITextField *tempTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        [tempTextField setAdjustsFontSizeToFitWidth:YES];
        [tempTextField setContentVerticalAlignment:UIControlContentHorizontalAlignmentCenter];
        [tempTextField setFont:[UIFont systemFontOfSize:13]];
        [tempTextField setBorderStyle:UITextBorderStyleNone]; 
        tempTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        tempTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        tempTextField.returnKeyType = UIReturnKeyDone;
        tempTextField.borderStyle = UITextBorderStyleRoundedRect;
        tempTextField.backgroundColor = [UIColor grayColor];
        tempTextField.keyboardType = UIKeyboardAppearanceDefault;
        tempTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:tempTextField];
        self.numberTextField = tempTextField;
        [tempTextField release];
        
        //注册textfield发生改变的通知，当textfield在编辑的时候会调用，打一个字调用一次
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textfieldChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
        
        //查询按钮
        UIButton *tempInquiryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [tempInquiryButton setFrame:CGRectZero];
        [tempInquiryButton addTarget:self action:@selector(clickToInquiryPhoneNumberMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempInquiryButton];
        self.inquiryButton = tempInquiryButton;
        
        //设置所有控件的frame，相对的布局
        selfNumberLabel.frame = CGRectMake(STARTX, STARTY, LABELWIDTH, LABELHEITHG);
        selfProvinceLabel.frame = CGRectMake(STARTX, selfNumberLabel.frame.origin.y+selfNumberLabel.frame.size.height+SPACE, LABELWIDTH, LABELHEITHG);
        selfCityLabel.frame = CGRectMake(STARTX, selfProvinceLabel.frame.origin.y+selfProvinceLabel.frame.size.height+SPACE, LABELWIDTH, LABELHEITHG);
        selfCardTypeLabel.frame = CGRectMake(STARTX, selfCityLabel.frame.origin.y+selfCityLabel.frame.size.height+SPACE, LABELWIDTH, LABELHEITHG);
        selfNumberTextField.frame = CGRectMake(STARTX, selfCardTypeLabel.frame.origin.y+selfCardTypeLabel.frame.size.height+SPACE, 200, LABELHEITHG);
        selfInquiryButton.frame = CGRectMake(selfNumberTextField.frame.origin.x+selfNumberTextField.frame.size.width+SPACE, selfCardTypeLabel.frame.origin.y+selfCardTypeLabel.frame.size.height+SPACE, 80, 50);
        
        //设置初始化的标题
        selfProvinceLabel.text = @"省份：";
        selfCityLabel.text = @"城市：";
        selfCardTypeLabel.text = @"卡类型：";
        [tempInquiryButton setTitle:@"查询" forState:UIControlStateNormal];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"phone";

    
    
    
}

#pragma mark -
#pragma mark 查询按钮的点击
- (void)clickToInquiryPhoneNumberMethod:(id)sender
{
    //手机号码必须大于等于7位
    NSString *content = selfNumberTextField.text;
    if ([content length]>=7) {
        [self findNumberMethod:content];
    }else{
        NSLog(@"at least 7");
    }

}

#pragma mark -
#pragma mark TextField 开始编辑后会调用的方法
- (void)textfieldChange:(id)sender
{
    //手机号码必须大于等于7位
    NSString *content = selfNumberTextField.text;
    if ([content length]>=7) {
        [self findNumberMethod:content];
    }

}

#pragma mark -
#pragma mark 请求数据
- (void)findNumberMethod:(NSString *)number
{
    //请求回来的数据赋给numberData这个数据对象
    [DataSource findPhoneNumbers:number resultBlock:^(id dataSource) {
        self.numberData = (PhoneNumberObject *)dataSource;
        
    } failedBlock:^(NSString *error) {
        NSLog(@"%@",error);
        
    }];
    
}

//numberData这个属性的set方法，每次赋值的时候会自动调用
- (void)setNumberData:(PhoneNumberObject *)numberData
{
    selfNumberData = numberData;
    
    //重新给label的内容赋值
    selfNumberLabel.text = selfNumberData.numberString;
    selfProvinceLabel.text = selfNumberData.provinceString;
    selfCityLabel.text = selfNumberData.cityString;
    selfCardTypeLabel.text = selfNumberData.cardTypeString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
