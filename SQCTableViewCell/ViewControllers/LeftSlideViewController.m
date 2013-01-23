//
//  LeftSlideViewController.m
//  SQCTableViewCell
//
//  Created by sunqichao on 13-1-23.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "LeftSlideViewController.h"
#import "PhoneNumberViewController.h"
#import "WeatherViewController.h"
#import "SlideViewController.h"
@interface LeftSlideViewController ()

@end

@implementation LeftSlideViewController
@synthesize functionTableView = selfFunctionTableView;
@synthesize delegate;
@synthesize dataArray = selfDataArray;
@synthesize selectIndex = selfSelectIndex;
- (id)init
{
    self = [super init];
    if(self)
    {
        UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        bar.barStyle = UIBarStyleDefault;
        
        [self.view addSubview:bar];
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 400.0f)];
        table.delegate = self;
        table.dataSource = self;
        [self.view addSubview:table];
        self.functionTableView = table;
        [table release];
        
        NSMutableArray *marr = [[NSMutableArray alloc] initWithObjects:@"手机号归属地查询",@"天气预报查询", nil];
        self.dataArray = marr;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
}

- (void)initWithController
{
    if ([delegate respondsToSelector:@selector(leftSelectMethod:)]) {
        [delegate leftSelectMethod:[self subConWithIndex:0]];
        self.selectIndex = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UINavigationController *)subConWithIndex:(int)index
{
    switch (index) {
        case 0:
        {
            PhoneNumberViewController *phone = [[PhoneNumberViewController alloc] init];
            UINavigationController *navgation= [[UINavigationController alloc] initWithRootViewController:phone];
            navgation.navigationBar.hidden = YES;
            return navgation;
        }
            break;
        case 1:
        {
            WeatherViewController *weather = [[WeatherViewController alloc] init];
            UINavigationController *navgation= [[UINavigationController alloc] initWithRootViewController:weather];
            navgation.navigationBar.hidden = YES;
            return navgation;
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark
#pragma mark - UITableViewDelegate      UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selfDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [selfDataArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([delegate respondsToSelector:@selector(leftSelectMethod:)]) {
        if (indexPath.row == selfSelectIndex) {
            [delegate leftSelectMethod:nil];
        }else
        {
            [delegate leftSelectMethod:[self subConWithIndex:indexPath.row]];
        }
        
    }
    self.selectIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
