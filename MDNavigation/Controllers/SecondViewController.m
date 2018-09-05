//
//  SecondViewController.m
//  MDNavigation
//
//  Created by 李永杰 on 2018/9/5.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTitle = @"第二个";
    [self.navigationBar setBackgroundColor:[UIColor blueColor]];
    [self.navigationBar setBackAlpha:0.3 onlyBack:NO];
    [self.navigationBar setLineColor:[UIColor redColor]];
    [self.navigationBar setLineHidden:YES];
    
    
    //修改item，文字，图片，内间距
    [self.navigationBar setItemWithTag:523 title:@"好的好的" titleColor:[UIColor redColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] radius:6 state:UIControlStateNormal];
    
    [self.navigationBar setItemWithTag:423 image:@"fanhui1" edgInset:UIEdgeInsetsMake(5, 5, 5, 5) state:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
