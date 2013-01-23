//
//  MainViewController.m
//  SQCTableViewCell
//
//  Created by sun qichao on 13-1-22.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "MainViewController.h"
#import "WeatherViewController.h"
#import "PhoneNumberViewController.h"

#define DATASOURCENUMBER 1000

@interface MainViewController ()
@end

@implementation MainViewController
@synthesize tableView = _tableView;
@synthesize numberData = _numberData;
@synthesize tableViewData = _tableViewData;
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"phoneNumber";
        CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f-44.0f);
        //创建tableview并赋给self.tableview。
        UITableView *table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        [self.view addSubview:table];
        self.tableView = table;
        [table release];
        
        //右上角的跳转按钮，点击后会进入查询天气的页面
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoWeather:)];
        self.navigationItem.rightBarButtonItem = right;

    }
    return self;
}

- (void)gotoWeather:(id)sender
{
    PhoneNumberViewController *weather = [[PhoneNumberViewController alloc] init];
    [self.navigationController pushViewController:weather animated:YES];
    [weather release];
    
    
}

/**
    保存唯一的cell的index：再点击tableview中的查询按钮后会纪录下当前点击的那个cell的index
    作用是为了刷新指定cell的数据，根据index获得cell，再把查询的结果赋给cell
 */
static int cellIndex = 0;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initWithData];
}
#pragma mark -
#pragma mark 初始化数据源
- (void)initWithData
{
    /**
     下面key对应的值先设置为空，等点击查询后再赋值。
     
     KEY_CELLPROVINCE,KEY_CELLCITY,KEY_CELLCARDTYPE
     
     */
    
    NSMutableArray *tableViewArray = [[NSMutableArray alloc] initWithCapacity:DATASOURCENUMBER];
    
    //循环添加数据 ,数量是 DATASOURCENUMBER
    for (int i=0; i<=DATASOURCENUMBER; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"15021944855",KEY_CELLPHONENUMBER,
                                    @"省份：",KEY_CELLPROVINCE,
                                    @"城市：",KEY_CELLCITY,
                                    @"手机卡类型：",KEY_CELLCARDTYPE,
                                    [NSString stringWithFormat:@"%d",i],KEY_CELLINDEX,nil];
        [tableViewArray addObject:dic];
    }
    
    self.tableViewData = tableViewArray;
}

//tableViewData的set方法会刷新整个表的数据
- (void)setTableViewData:(NSMutableArray *)tableViewData
{
    _tableViewData = tableViewData;
    [self.tableView reloadData];
}

//data的set方法会刷新指定cell的数据
- (void)setNumberData:(PhoneNumberObject *)numberData
{
    _numberData = numberData;
    //根据index创建indexpath
    NSIndexPath *index = [NSIndexPath indexPathForRow:cellIndex inSection:0];
    //根据indexpath找到对应的cell
    MainViewTableViewCell *cell = (MainViewTableViewCell *)[self.tableView cellForRowAtIndexPath:index];
    //把查询回来的数据赋给cell的data
    [CATransaction begin];
    [CATransaction setAnimationDuration:5.0f];
    cell.label_number.layer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
    [CATransaction commit];
    cell.numberData = _numberData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITableViewDataSource 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableViewData) {
        return [_tableViewData count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainViewTableViewCell";
    
    MainViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MainViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //设置点击的委托
    cell.delegate = self;
    cell.data = [_tableViewData objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark -
#pragma mark 查询按钮的委托方法
- (void)phoneNumberFindMethod:(id)sender
{
    //获得点击的按钮
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%d",btn.tag);
    //根据按钮的tag获得index
    cellIndex = btn.tag;
    
    //找到指定的数据
    NSDictionary *dic = [_tableViewData objectAtIndex:cellIndex];
    NSLog(@"%@",[dic objectForKey:KEY_CELLPHONENUMBER]);

    //调用查询的方法
    [DataSource findPhoneNumbers:[dic objectForKey:KEY_CELLPHONENUMBER] resultBlock:^(PhoneNumberObject *dataSource) {
        self.numberData = dataSource;
        //创建新的数据字典
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    dataSource.numberString,KEY_CELLPHONENUMBER,
                                    dataSource.provinceString,KEY_CELLPROVINCE,
                                    dataSource.cityString,KEY_CELLCITY,
                                    dataSource.cardTypeString,KEY_CELLCARDTYPE,
                                    [NSString stringWithFormat:@"%d",cellIndex],KEY_CELLINDEX,nil];
        //替换旧的数据
        [self.tableViewData replaceObjectAtIndex:cellIndex withObject:dic];
        
    } failedBlock:^(NSString *error) {
        NSLog(@"%@",error);
        
    }];
}


@end
