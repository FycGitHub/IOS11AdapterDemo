//
//  ViewController.m
//  IOS11AdapterDemo
//
//  Created by Frank on 2017/9/21.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>
{
    NSMutableArray          *_dataList;
    UITableView             *_tableView;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    [self initData];
    [self createUI];
    
    // 设置标题
    self.navigationController.navigationBar.prefersLargeTitles = true;
    // 自动设置
    // UINavigationItemLargeTitleDisplayModeAutomatic
    // 大标题
    // UINavigationItemLargeTitleDisplayModeAlways
    // 小标题
    // UINavigationItemLargeTitleDisplayModeNever
    
    self.navigationItem.largeTitleDisplayMode =  UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationItem.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
}
- (void)initData {
    _dataList = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
}
- (void)createUI {
    float  width = [UIScreen mainScreen].bounds.size.width;
    float  heigth = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, heigth) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataList[indexPath.row]];
    return cell;
}
#pragma mark 左滑删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//  第一种方法
//*8.0之后出现的可以设置左划后显示的内容
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:1 title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        if ([_dataList count]>indexPath.row) {
            [_dataList removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        }
    }];
    action1.backgroundColor = [UIColor redColor];
    return @[action1];
}
// 第二种 ios 11
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        if ([_dataList count]>indexPath.row) {
            [_dataList removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        }
        completionHandler (YES);
    }];
    deleteRowAction.image = [UIImage imageNamed:@"icon_del"];
    deleteRowAction.backgroundColor = [UIColor blueColor];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eat {
    
}
@end
