//
//  ThirdViewController.m
//  MDNavigation
//
//  Created by 李永杰 on 2018/9/5.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"第三个";
    //左边添加个按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"en1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(0, 122200, 100, 30)];//大小位置，可以不设置
    [self.navigationBar addItemWithPosition:MDNavigationBarItemPositionLeft item:btn1];
    //右边添加个按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"hello" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationBar addItemWithPosition:MDNavigationBarItemPositionRight item:btn];
}
//重写父类方法
-(void)clickNavigationLeftBtnAction:(NSInteger)tag{
    if (tag == 423) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        NSLog(@"点击了左边第二个按钮");
    }
}
-(void)clickNavigationRightBtnAction:(NSInteger)tag{
    NSLog(@"点击了tag为:%ld的按钮",tag);
}


@end
