//
//  MDNavigationBar.h
//  Muheda
//
//  Created by liyongjie on 2018/4/23.
//  Copyright © 2018年 于朝盼. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
    
#define Is_iPhone_X             [UIScreen mainScreen].bounds.size.height == 812 ? YES : NO
#define MDNavigationHeight      ([UIScreen mainScreen].bounds.size.height == 812 ? 88 : 64)

@protocol MDNavigationBarDelegate <NSObject>

@optional
-(void)didClickNavigationWithTag:(NSInteger )tag;

@end
//点击事件
typedef void(^MDNavigationBarActionBlock)(NSInteger tag);

//七种排版类型
typedef NS_ENUM(NSInteger,MDNavigationBarStyle){
    MDNavigationBarStyleDefault,
    MDNavigationBarStyleMiddleAndRight,
    MDNavigationBarStyleRightOnly,
    MDNavigationBarStyleLeftAndMiddle,
    MDNavigationBarStyleLeftOnly,
    MDNavigationBarStyleMiddleOnly,
    MDNavigationBarStyleLeftAndRight
};
//添加左或者右item
typedef NS_ENUM(NSInteger,MDNavigationBarItemPosition){
    MDNavigationBarItemPositionLeft,
    MDNavigationBarItemPositionRight
};

@interface MDNavigationBar : UIView
//中间title，颜色，字体,单个设置或者用富文本
@property (nonatomic, copy)   NSString                          *title;
@property (nonatomic, strong) UIColor                           *titleLabelColor;
@property (nonatomic, strong) UIFont                            *titleLabelFont;
@property (nonatomic, strong) NSAttributedString                *titleLabelAttribute;
//背景图片，颜色,透明度
@property (nonatomic, strong) UIColor                           *backgroundColor;
@property (nonatomic, strong) NSString                          *backgroundImageName;
@property (nonatomic, strong) UIColor                           *lineColor;
@property (nonatomic, assign) CGFloat                           backAlpha;
//左右item和中间的自定义视图
@property (nonatomic, copy)   NSMutableArray                    *leftItems;
@property (nonatomic, copy)   NSMutableArray                    *rightItems;
@property (nonatomic, strong) UIView                            *headerView;

//排版类型
@property (nonatomic, assign) MDNavigationBarStyle              navigationStyle;
//处理事件，block回调
@property (nonatomic, copy)   MDNavigationBarActionBlock        actionBlock;
//处理事件，代理
@property (nonatomic, assign) id<MDNavigationBarDelegate>       navigationBarDelegate;

//创建导航栏
+(instancetype)mdNavigationBar;
//可以动态添加item
-(void)addItemWithPosition:(MDNavigationBarItemPosition )position item:(UIButton *)item;
//Y方向偏移
-(void)transitionY:(CGFloat)y;
//设置导航栏itemframe,0：左，1：右
-(void)setItemFrame:(int)position frame:(CGRect )frame;
@end
