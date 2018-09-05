//
//  FourthViewController.m
//  MDNavigation
//
//  Created by 李永杰 on 2018/9/5.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTitle = @"第四个";
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"搜索职位/公司/商区" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"Checkmark"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 230, 30)];
    self.navigationBar.headerView = btn2;
    
    [self.navigationBar setItemWithTag:423 image:@"fanhui1" edgInset:UIEdgeInsetsMake(5, 5, 5, 5) state:UIControlStateNormal];

}

@end
