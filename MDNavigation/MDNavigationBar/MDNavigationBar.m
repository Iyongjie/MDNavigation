//
//  MDNavigationBar.m
//  Muheda
//
//  Created by liyongjie on 2018/4/23.
//  Copyright © 2018年 于朝盼. All rights reserved.
//

#import "MDNavigationBar.h"
#define MDNavigationBarDefaultBackgroundColor   [UIColor whiteColor]
#define MDNavigationBarScreenWidth              [UIScreen mainScreen].bounds.size.width
#define MHDNavigtionBarTop                      CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define leftMargin           5
#define middleMargin         5
#define rightMargin          5
#define LEFT_BTN_TAG         423
#define RIGHT_BTN_TAG        523
#define BTN_WIDTH            44
#define BTN_HEIGHT           44
#define CONTENT_VIEW_HEIGHT  44

@interface MDNavigationBar ()

@property (nonatomic, strong)  UIView          *backgroundView;
@property (nonatomic, strong)  UIImageView     *backgroundImageView;
@property (nonatomic, strong)  UIView          *leftView;
@property (nonatomic, strong)  UIView          *middleView;
@property (nonatomic, strong)  UILabel         *titleLabel;
@property (nonatomic, strong)  UIView          *rightView;
@property (nonatomic, strong)  UIView          *bottomLineView;
@property (nonatomic, assign)  CGFloat         leftViewWidth;
@property (nonatomic, assign)  CGFloat         middleViewWidth;
@property (nonatomic, assign)  CGFloat         rightViewWidth;

@end

@implementation MDNavigationBar

#pragma mark - init
+(instancetype)mdNavigationBar{
    
    MDNavigationBar *navigationBar = [[self alloc]initWithFrame:CGRectMake(0,0,MDNavigationBarScreenWidth,MDNavigationHeight)];
    navigationBar.navigationStyle = MDNavigationBarStyleDefault;
    navigationBar.backgroundColor = [UIColor clearColor];
    navigationBar.backgroundView.backgroundColor = MDNavigationBarDefaultBackgroundColor;
    navigationBar.backgroundImageView.hidden = YES;
    navigationBar.titleLabelFont = [UIFont fontWithName:@"PingFangTC-Semibold" size:18];
    navigationBar.titleLabelColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    navigationBar.bottomLineView.backgroundColor = [UIColor colorWithRed:(CGFloat)(218.0/255.0) green:(CGFloat)(218.0/255.0) blue:(CGFloat)(218.0/255.0) alpha:1.0];
    
    
    //默认添加，左中右，item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui1"] forState:UIControlStateNormal];
    navigationBar.leftItems = [NSMutableArray arrayWithObjects:leftBtn, nil];
    
    navigationBar.title = @"title";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"fanhui1"] forState:UIControlStateNormal];
    navigationBar.rightItems = [NSMutableArray arrayWithObjects:rightBtn, nil];
    
    
    return navigationBar;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI{
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.middleView];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.bottomLineView];
    [self updateFrame];
}

#pragma mark - update frame
-(void)updateFrame{
    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.backgroundView.bounds;
    self.bottomLineView.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), MDNavigationBarScreenWidth, 0.5);
    self.leftView.frame = CGRectMake(0, MHDNavigtionBarTop, self.leftViewWidth, CONTENT_VIEW_HEIGHT);
    self.rightView.frame = CGRectMake(self.backgroundView.frame.size.width - self.rightViewWidth, MHDNavigtionBarTop, self.rightViewWidth, CONTENT_VIEW_HEIGHT);
    self.middleView.frame = CGRectMake((self.backgroundView.frame.size.width-self.middleViewWidth) / 2.0, MHDNavigtionBarTop, self.middleViewWidth, CONTENT_VIEW_HEIGHT);
}

#pragma mark - add item
-(void)addItemWithPosition:(MDNavigationBarItemPosition)position item:(UIButton *)item{
    if (position == MDNavigationBarItemPositionLeft) {
        [self.leftItems addObject:item];
        [self addLeftViewItems];
    }else{
        [self.rightItems addObject:item];
        [self addRightViewItems];
    }
}

#pragma mark - 添加左，中，右视图
//更新左边底部视图frame,添加左边item
-(void)addLeftViewItems{
    //n个item，左边视图宽=n*(item宽+间距)+间距
    self.leftViewWidth = self.leftItems.count*(BTN_WIDTH+leftMargin)+leftMargin;
    self.leftView.frame = CGRectMake(0, MHDNavigtionBarTop, self.leftViewWidth, CONTENT_VIEW_HEIGHT);
    for (int i = 0 ; i< self.leftItems.count; i++) {
        UIButton *btn = (UIButton *)self.leftItems[i];
        CGRect rect = CGRectMake(leftMargin+(BTN_WIDTH+leftMargin)*i, 0, BTN_WIDTH, BTN_HEIGHT);
        [self.leftView addSubview:btn];
        [btn setFrame:rect];
        btn.tag = LEFT_BTN_TAG+i;
        [btn addTarget:self action:@selector(clickLeftOrRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//更新中间底部视图frame，添加titlelabel
-(void)addMiddleLabel{
    
    //title最大长度，不超过屏幕的三分之二
    if (self.middleViewWidth >= MDNavigationBarScreenWidth/3*2) {
        self.middleViewWidth = MDNavigationBarScreenWidth/3*2;
    }
    self.middleView.frame = CGRectMake((self.backgroundView.frame.size.width-self.middleViewWidth) / 2.0, MHDNavigtionBarTop, self.middleViewWidth, CONTENT_VIEW_HEIGHT);
    self.titleLabel.frame = CGRectMake(0, 0, self.middleViewWidth, self.middleView.frame.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.middleView addSubview:self.titleLabel];
}
//移除titlabel，更新中间底部视图frame，添加头视图
-(void)addHeaderView{
    [self.titleLabel removeFromSuperview];
    self.titleLabel = nil;
    CGRect frame = self.headerView.frame;
    self.middleView.frame = CGRectMake((self.frame.size.width-frame.size.width)/2.0, MHDNavigtionBarTop+(CONTENT_VIEW_HEIGHT - frame.size.height)/2.0, frame.size.width, frame.size.height);
    [self.middleView addSubview:self.headerView];
}
//更新右边底部视图的frame，添加右边item
-(void)addRightViewItems{
    //n个item，右边视图宽=n*(item宽+间距)+间距
    self.rightViewWidth = self.rightItems.count*(BTN_WIDTH+rightMargin)+rightMargin;
    self.rightView.frame = CGRectMake(self.backgroundView.frame.size.width - self.rightViewWidth, MHDNavigtionBarTop, self.rightViewWidth, CONTENT_VIEW_HEIGHT);
    for (int i = 0; i<self.rightItems.count; i++) {
        UIButton *btn = (UIButton *)self.rightItems[i];
        CGRect rect = CGRectMake(rightMargin + (BTN_WIDTH + rightMargin)*i, 0, BTN_WIDTH, BTN_HEIGHT);
        [self.rightView addSubview:btn];
        [btn setFrame:rect];
        btn.tag = RIGHT_BTN_TAG+i;
        [btn addTarget:self action:@selector(clickLeftOrRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - click button
-(void)clickLeftOrRightBtn:(UIButton *)sender{
    if (_actionBlock) {
        _actionBlock(sender.tag);
    }
    if (self.navigationBarDelegate && [self.navigationBarDelegate respondsToSelector:@selector(didClickNavigationWithTag:)]) {
        [self.navigationBarDelegate didClickNavigationWithTag:sender.tag];
    }
}

#pragma mark - 设置颜色，图片
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    self.backgroundImageView.hidden = YES;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = backgroundColor;
}

-(void)setBackgroundImageName:(NSString *)backgroundImageName{
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = [UIImage imageNamed:backgroundImageName];
}
//
-(void)setBackAlpha:(CGFloat)backAlpha onlyBack:(BOOL)yes{
    if (yes) {
        self.backgroundView.alpha = backAlpha;
        self.backgroundImageView.alpha = backAlpha;
        self.bottomLineView.alpha = backAlpha;
    }else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.alpha = backAlpha;
        }];
    }
    

}
-(void)setNavTintColor:(UIColor *)color{
    [self.leftView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:color forState:UIControlStateNormal];
        }
    }];
    [self.rightView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:color forState:UIControlStateNormal];
        }
    }];
    
    self.titleLabel.textColor = color;
}

#pragma mark - 设置item
-(void)setLeftItems:(NSMutableArray *)leftItems{
    _leftItems = leftItems;
    [self.leftView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addLeftViewItems];
}

-(void)setRightItems:(NSMutableArray *)rightItems{
    _rightItems = rightItems;
    [self.rightView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addRightViewItems];
}

-(void)setTitleLabelAttribute:(NSAttributedString *)titleLabelAttribute{
    _titleLabelAttribute = titleLabelAttribute;
    _titleLabel.attributedText = _titleLabelAttribute;
    self.middleViewWidth = [self calculateStringWidth:titleLabelAttribute.string];
    [self addMiddleLabel];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.middleViewWidth = [self calculateStringWidth:title];
    [self addMiddleLabel];
    self.titleLabel.text = _title;
}

-(void)setTitleLabelColor:(UIColor *)titleLabelColor{
    _titleLabelColor = titleLabelColor;
    self.titleLabel.textColor = _titleLabelColor;
}

-(void)setTitleLabelFont:(UIFont *)titleLabelFont{
    _titleLabelFont = titleLabelFont;
    [self.titleLabel setFont:_titleLabelFont];
}

-(void)setHeaderView:(UIView *)headerView{
    _headerView = headerView;
    [self addHeaderView];
}

-(void)setLineColor:(UIColor *)lineColor{
    self.bottomLineView.backgroundColor = lineColor;
}
-(void)setLineHidden:(BOOL)hidden{
    self.bottomLineView.hidden = hidden;
}

-(void)setNavigationStyle:(MDNavigationBarStyle)navigationStyle{
    
    switch (navigationStyle) {
        case MDNavigationBarStyleDefault:{
            [self addLeftViewItems];
            [self addMiddleLabel];
            [self addRightViewItems];
        }
            break;
        case MDNavigationBarStyleLeftOnly:{
            [self.middleView removeFromSuperview];
            self.middleView = nil;
            [self.rightView removeFromSuperview];
            self.rightView = nil;
            [self addLeftViewItems];
        }
            break;
        case MDNavigationBarStyleRightOnly:{
            [self.leftView removeFromSuperview];
            self.leftView = nil;
            [self.middleView removeFromSuperview];
            self.middleView = nil;
            [self addRightViewItems];
        }
            break;
        case MDNavigationBarStyleMiddleOnly:{
            [self.leftView removeFromSuperview];
            self.leftView = nil;
            [self.rightView removeFromSuperview];
            self.rightView = nil;
            [self addMiddleLabel];
        }
            break;
        case MDNavigationBarStyleLeftAndRight:{
            [self.middleView removeFromSuperview];
            self.middleView = nil;
            [self addLeftViewItems];
            [self addRightViewItems];
        }
            break;
        case MDNavigationBarStyleLeftAndMiddle:{
            [self.rightView removeFromSuperview];
            self.rightView = nil;
            [self addLeftViewItems];
            [self addMiddleLabel];
        }
            break;
        case MDNavigationBarStyleMiddleAndRight:{
            [self.leftView removeFromSuperview];
            self.leftView = nil;
            [self addMiddleLabel];
            [self addRightViewItems];
        }
            break;
        default:{
            [self addLeftViewItems];
            [self addMiddleLabel];
            [self addRightViewItems];
        }
            break;
    }
}

#pragma mark - getter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
    }
    return _backgroundView;
}

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageView;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
    }
    return _bottomLineView;
}

-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
    }
    return _leftView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
    }
    return _rightView;
}

-(UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc]init];
    }
    return _middleView;
}

#pragma mark - instance method
- (CGFloat)calculateStringWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:self.titleLabelFont};
    //计算宽度时要确定高度
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, CONTENT_VIEW_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width+10;
}

-(void)transitionY:(CGFloat)y{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.transform = CGAffineTransformMakeTranslation(0, y);
    }];
}

//根据tag设置item
-(void)setItemWithTag:(int)tag image:(NSString *)imageName edgInset:(UIEdgeInsets)edgInset state:(UIControlState)state{
    if (tag < 523) {
        UIButton *btn = (UIButton *)[self.leftView viewWithTag:tag];
        [btn setImage:[UIImage imageNamed:imageName] forState:state];
        [btn setImageEdgeInsets:edgInset];
        [self setBtn:btn title:@"" titleColor:nil backgroundColor:[UIColor clearColor] font:nil radius:0 state:state];

    }else{
        UIButton *btn = (UIButton *)[self.rightView viewWithTag:tag];
        [btn setImage:[UIImage imageNamed:imageName] forState:state];
        [btn setImageEdgeInsets:edgInset];
        [self setBtn:btn title:@"" titleColor:nil backgroundColor:[UIColor clearColor] font:nil radius:0 state:state];

    }
}
-(void)setItemWithTag:(int)tag title:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font radius:(CGFloat)radius state:(UIControlState)state{
    if (tag < 523) {
        UIButton *btn = (UIButton *)[self.leftView viewWithTag:tag];
        [self setBtn:btn title:title titleColor:color backgroundColor:backgroundColor font:font radius:radius state:state];
    }else{
        UIButton *btn = (UIButton *)[self.rightView viewWithTag:tag];
        [self setBtn:btn title:title titleColor:color backgroundColor:backgroundColor font:font radius:radius state:state];
    }
}
-(void)setBtn:(UIButton *)btn title:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font radius:(CGFloat )radius state:(UIControlState)state{
    [btn setTitle:title forState:state];
    [btn setTitleColor:color forState:state];
    [btn setBackgroundImage:[self imageWithColor:backgroundColor] forState:state];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = font;
}
//根据颜色返回图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
