//
//  BaseViewController.m
//  MDNavigation
//
//  Created by 李永杰 on 2018/9/5.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<MDNavigationBarDelegate>
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES];
}

//点击左边导航栏按钮
-(void)clickNavigationLeftBtnAction:(NSInteger)tag{
    if (tag == 423) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//点击右边导航栏按钮
-(void)clickNavigationRightBtnAction:(NSInteger)tag{
    
}
#pragma mark - MHDNavigationBarDelegate
-(void)didClickNavigationWithTag:(NSInteger)tag{
    if (tag < 523) {//点击左边的按钮，423，424,425
        [self clickNavigationLeftBtnAction:tag];
    }else{//点击右边的按钮，523，524,525
        [self clickNavigationRightBtnAction:tag];
    }
}

-(void)setNaviTitle:(NSString *)naviTitle{
    _naviTitle = naviTitle;
    self.navigationBar.title = _naviTitle;
}
#pragma mark - 懒加载

-(MDNavigationBar *)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [MDNavigationBar mdNavigationBar];
        _navigationBar.navigationBarDelegate = self;
    }
    return _navigationBar;
}

-(void)dealloc{
    [self.navigationBar removeFromSuperview];
    self.navigationBar = nil;
}

@end
