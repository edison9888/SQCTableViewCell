//
//  MainViewTableViewCell.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "MainViewTableViewCell.h"
/**
 定义的是label的宽度，高度，和间隔距离
 布局是这样的，分左右两边，左边的控件宽度都是100
                      右边的宽度都是200
 */
#define LABELFONT 14
#define LABELHEIGHT 30
#define LABELWIDTH_LEFT 100
#define LABELWIDTH_RIGHT 200
#define SPACE 5
@implementation MainViewTableViewCell
@synthesize numberData = _numberData;
@synthesize data = _data;
@synthesize label_number = _label_number;
@synthesize label_phoneNumber = _label_phoneNumber;
@synthesize label_province = _label_province;
@synthesize label_city = _label_city;
@synthesize label_cardType = _label_cardType;
@synthesize btn_find = _btn_find;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //显示cell的index
        UILabel *temp_number = [[UILabel alloc] initWithFrame:CGRectZero];
		temp_number.backgroundColor = [UIColor clearColor];
		temp_number.textColor = [UIColor blackColor];
        temp_number.textAlignment = NSTextAlignmentCenter;
		temp_number.font = [UIFont systemFontOfSize:LABELFONT];
		[self.contentView addSubview:temp_number];
		self.label_number = temp_number;
		[temp_number release];
        
        //显示手机号码的label
        UILabel *temp_phone = [[UILabel alloc] initWithFrame:CGRectZero];
		temp_phone.backgroundColor = [UIColor clearColor];
		temp_phone.textColor = [UIColor blackColor];
		temp_phone.font = [UIFont systemFontOfSize:LABELFONT];
		[self.contentView addSubview:temp_phone];
		self.label_phoneNumber = temp_phone;
		[temp_phone release];
        
        //显示省份
        UILabel *temp_province = [[UILabel alloc] initWithFrame:CGRectZero];
		temp_province.backgroundColor = [UIColor clearColor];
		temp_province.textColor = [UIColor blackColor];
		temp_province.font = [UIFont systemFontOfSize:LABELFONT];
		[self.contentView addSubview:temp_province];
		self.label_province = temp_province;
		[temp_province release];

        //显示城市
        UILabel *temp_city = [[UILabel alloc] initWithFrame:CGRectZero];
		temp_city.backgroundColor = [UIColor clearColor];
		temp_city.textColor = [UIColor blackColor];
		temp_city.font = [UIFont systemFontOfSize:LABELFONT];
		[self.contentView addSubview:temp_city];
		self.label_city = temp_city;
		[temp_city release];
        
        //显示手机卡的类型
        UILabel *temp_cardType = [[UILabel alloc] initWithFrame:CGRectZero];
		temp_cardType.backgroundColor = [UIColor clearColor];
		temp_cardType.textColor = [UIColor blackColor];
		temp_cardType.font = [UIFont systemFontOfSize:LABELFONT];
		[self.contentView addSubview:temp_cardType];
		self.label_cardType = temp_cardType;
		[temp_cardType release];
        
        //查询的按钮
        UIButton *temp_click = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [temp_click setTitle:@"查询" forState:UIControlStateNormal];
        [temp_click setFrame:CGRectZero];
        [temp_click addTarget:self action:@selector(clickMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:temp_click];
        self.btn_find = temp_click;
        
        
        
    }
    return self;
}

//查询按钮的方法，委托回调
- (void)clickMethod:(id)sender
{
    [_delegate phoneNumberFindMethod:sender];
}

//没有查询前的数据源data的set方法
- (void)setData:(NSDictionary *)data
{
    _data = data;
    //给点击的button设置tag，目的是为了通过tag找到点击的那个cell
    [_btn_find setTag:[[_data objectForKey:KEY_CELLINDEX] intValue]];
    
    _label_number.text = [_data objectForKey:KEY_CELLINDEX];
    _label_phoneNumber.text = [_data objectForKey:KEY_CELLPHONENUMBER];
    _label_province.text = [_data objectForKey:KEY_CELLPROVINCE];
    _label_city.text = [_data objectForKey:KEY_CELLCITY];
    _label_cardType.text = [_data objectForKey:KEY_CELLCARDTYPE];
    
    [self setNeedsLayout];

}

//查询过后的set方法
- (void)setNumberData:(PhoneNumberObject *)numberData
{
    _numberData = numberData;
    
    _label_province.text = _numberData.provinceString;
    _label_city.text = _numberData.cityString;
    _label_cardType.text = _numberData.cardTypeString;
    
    [self setNeedsLayout];

}

//设置所有控键的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    //左边的view设置
    _label_phoneNumber.frame = CGRectMake(SPACE, SPACE, LABELWIDTH_LEFT, LABELHEIGHT);
    _btn_find.frame = CGRectMake(SPACE, _label_phoneNumber.frame.origin.y+_label_phoneNumber.frame.size.height+SPACE, LABELWIDTH_LEFT, LABELHEIGHT);
    _label_number.frame = CGRectMake(SPACE, _btn_find.frame.origin.y+_btn_find.frame.size.height+SPACE, LABELWIDTH_LEFT, LABELHEIGHT);
    
    //右边的view设置
    _label_province.frame = CGRectMake(_label_phoneNumber.frame.origin.x+_label_phoneNumber.frame.size.width+SPACE, SPACE, LABELWIDTH_RIGHT, LABELHEIGHT);
    _label_city.frame = CGRectMake(_label_phoneNumber.frame.origin.x+_label_phoneNumber.frame.size.width+SPACE, _label_province.frame.origin.y+_label_province.frame.size.height+SPACE, LABELWIDTH_RIGHT, LABELHEIGHT);
    _label_cardType.frame = CGRectMake(_label_phoneNumber.frame.origin.x+_label_phoneNumber.frame.size.width+SPACE, _label_city.frame.origin.y+_label_city.frame.size.height+SPACE, LABELWIDTH_RIGHT, LABELHEIGHT);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
