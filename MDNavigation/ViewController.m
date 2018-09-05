//
//  ViewController.m
//  MDNavigation
//
//  Created by 李永杰 on 2018/9/4.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)NSArray *dataArr;
@property (nonatomic,copy)NSArray *desArr;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.title = @"MDNavigationBar";
    
}

#pragma mark - uitableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id obj = [[NSClassFromString(self.desArr[indexPath.row]) alloc]init];
    [self.navigationController pushViewController:obj animated:YES];
}
#pragma mark -- lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _tableView;
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"默认样式",@"修改背景颜色，图片",@"动态添加item",@"自定义头视图"];
    }
    return _dataArr;
}
-(NSArray *)desArr{
    if (!_desArr) {
        _desArr = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourthViewController"];
    }
    return _desArr;
}


@end
