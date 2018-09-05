//
//  BaseViewController.h
//  MDNavigation
//
//  Created by 李永杰 on 2018/9/5.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDNavigationBar.h"
@interface BaseViewController : UIViewController
@property (nonatomic,copy) NSString *naviTitle;
@property(nonatomic,strong)MDNavigationBar *navigationBar;


//点击左边导航栏按钮
-(void)clickNavigationLeftBtnAction:(NSInteger)tag;
//点击右边导航栏按钮
-(void)clickNavigationRightBtnAction:(NSInteger)tag;
@end
