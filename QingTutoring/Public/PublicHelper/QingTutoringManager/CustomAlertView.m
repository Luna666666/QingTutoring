//
//  CustomAlertView.m
//  AlertViewDemo
//
//  Created by apple on 17/2/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CustomAlertView.h"


#define kScreen_Width  [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height [[UIScreen mainScreen] bounds].size.height

#define kButtonHei 60
#define kDistance 30

#define kTitleFont 17
#define kMassageFont 17
#define kBtnTitleFont  18

@interface CustomAlertView (){
    UIView *_backgraoudView; //蒙板背景
    UIScrollView *_scrollView;
    UILabel *_titleLabel;
    UILabel *_massageLabel;
    UIView *_downView;
    UIView *_aletView;
    NSMutableArray *_titleBtnArray;
    
}
@end

@implementation CustomAlertView
-(instancetype)initWithTitle:(NSString *)title andWithMassage:(NSString *)massage andWithTag:(NSInteger)tag andWithButtonTitle:(NSString *)otherButtonTitles, ...{
    self = [super init];
    if (self) {
         self.frame = CGRectMake(0, 0,kScreen_Width, kScreen_Height);
         self.tag=tag;
        _titleBtnArray = [NSMutableArray array];
        //蒙板
        [_backgraoudView removeFromSuperview];
        _backgraoudView = nil;
        _backgraoudView = [[UIView alloc]init];
        _backgraoudView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
        _backgraoudView.backgroundColor = [UIColor blackColor];
        _backgraoudView.alpha = 0;
         [self addSubview:_backgraoudView];
        
        [UIView animateWithDuration:0.2 animations:^{
            _backgraoudView.alpha = 0.7;
        }];
        

        UIView *alertView = [[UIView alloc]init];
         alertView.backgroundColor = [UIColor whiteColor];
        alertView.frame = CGRectMake(kDistance, 0, kScreen_Width-kDistance*2, 1000);
        alertView.layer.masksToBounds = YES; //没这句话它圆不起来
        alertView.layer.cornerRadius =5; //设置图片圆角的尺度
        [self addSubview:alertView];
       
        //获取标题文字大小
        CGRect titleLabelRect = [self getStrimgRect:title andWithStringFontSize:kTitleFont andWithCurrentProlWitch:kScreen_Width-kDistance*2];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0, 10, kScreen_Width-kDistance*2, titleLabelRect.size.height);
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = title;
        titleLabel.numberOfLines = 0;
       // titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:kTitleFont]];
        [alertView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        //获取信息文字大
        
        //信息内容
        UILabel *massageLabel = [[UILabel alloc]init];
        massageLabel.backgroundColor = [UIColor whiteColor];
        massageLabel.textColor=UIColorFromRGB(kPopTitleColor);
        massageLabel.text = massage;
        massageLabel.numberOfLines = 0;
        massageLabel.font = [UIFont systemFontOfSize:kMassageFont];
        massageLabel.textAlignment = NSTextAlignmentCenter;
      
                massageLabel.frame =
            CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10*ScaleWidth, kScreen_Width-60*ScaleWidth,60*ScaleWidth);
                if (massage == nil||[massage isEqualToString:@""]) {
                    massageLabel.frame =
                    CGRectMake(0, CGRectGetMaxY(titleLabel.frame), kScreen_Width-60*ScaleWidth, 1);
                }

        [alertView addSubview:massageLabel];
        _massageLabel = massageLabel;
        
        
        //添加按钮
        va_list args;
        va_start(args, otherButtonTitles);
        NSMutableArray *buttonTitleArray = [NSMutableArray array];
        NSMutableString *allStr = [[NSMutableString alloc] initWithCapacity:16];
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
             [allStr appendFormat:@"%@,",str];
            [buttonTitleArray addObject:str];
        }
        
        //创建按钮
        //判断按钮是一个的时候
        if (buttonTitleArray.count == 1) {
            [_titleBtnArray removeAllObjects];
            UIButton *oneBtn = [[UIButton alloc]init];
            oneBtn.frame = CGRectMake(0, CGRectGetMaxY(massageLabel.frame)+15, massageLabel.frame.size.width ,kButtonHei);
            [oneBtn setTitle:buttonTitleArray[0] forState:(UIControlStateNormal)];
            [oneBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
            oneBtn.backgroundColor = [UIColor whiteColor];
            oneBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnTitleFont];
            [oneBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:kBtnTitleFont]];
            oneBtn.tag = 0;
            [oneBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [alertView addSubview:oneBtn];
           
            [oneBtn addSubview:[self getLineView:CGRectMake(0, 0, massageLabel.frame.size.width, 0.5)]];
             alertView.frame = CGRectMake(kDistance, 0, kScreen_Width-kDistance*2, CGRectGetMaxY(oneBtn.frame));
            
            [_titleBtnArray addObject:oneBtn];
        }
        
    //判断按钮是两个的时候
       else if (buttonTitleArray.count == 2) {
             [_titleBtnArray removeAllObjects];
            CGRect oneBtnTitleRect = [self getStrimgRect:buttonTitleArray[0] andWithStringFontSize:18*ScaleWidth andWithCurrentProlWitch:massageLabel.frame.size.width];
            CGRect twoBtnTitleRect = [self getStrimgRect:buttonTitleArray[1] andWithStringFontSize:18*ScaleWidth andWithCurrentProlWitch:massageLabel.frame.size.width];
            
            UIButton *oneBtn = [[UIButton alloc]init];
            [oneBtn setTitle:buttonTitleArray[0] forState:(UIControlStateNormal)];
            [oneBtn setTitleColor:UIColorFromRGB(kCancelColor)forState:(UIControlStateNormal)];
            oneBtn.backgroundColor = [UIColor whiteColor];
            oneBtn.titleLabel.font = [UIFont systemFontOfSize:18*ScaleWidth];
            [oneBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18*ScaleWidth]];
            oneBtn.tag = 0;
            [oneBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
           [_titleBtnArray addObject:oneBtn];

            [alertView addSubview:oneBtn];
            [oneBtn addSubview:[self getLineView:CGRectMake(0, 0, massageLabel.frame.size.width, 0.5*ScaleWidth)]];
           
           
            UIButton *twoBtn = [[UIButton alloc]init];
            [twoBtn setTitle:buttonTitleArray[1] forState:(UIControlStateNormal)];
            [twoBtn setTitleColor:UIColorFromRGB(kSureColor) forState:(UIControlStateNormal)];
            twoBtn.backgroundColor = [UIColor whiteColor];
            twoBtn.titleLabel.font = [UIFont systemFontOfSize:18*ScaleWidth];
            [twoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18*ScaleWidth]];
            twoBtn.tag = 1;
            [twoBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [_titleBtnArray addObject:twoBtn];

            [alertView addSubview:twoBtn];
            [twoBtn addSubview:[self getLineView:CGRectMake(0, 0, massageLabel.frame.size.width, 0.5*ScaleWidth)]];
           
    
           //判断button文字长度
            if (oneBtnTitleRect.size.width>massageLabel.frame.size.width/2
                ||twoBtnTitleRect.size.width>massageLabel.frame.size.width/2) {
               
                    oneBtn.frame = CGRectMake(0, CGRectGetMaxY(massageLabel.frame)+15*ScaleWidth, massageLabel.frame.size.width ,60*ScaleWidth);
                    twoBtn.frame = CGRectMake(0, CGRectGetMaxY(oneBtn.frame), massageLabel.frame.size.width ,60*ScaleWidth);
            }else{
                    oneBtn.frame = CGRectMake(0, CGRectGetMaxY(massageLabel.frame)+15*ScaleWidth, massageLabel.frame.size.width/2,60*ScaleWidth);
                    twoBtn.frame = CGRectMake(CGRectGetMaxX(oneBtn.frame), CGRectGetMaxY(massageLabel.frame)+15*ScaleWidth, massageLabel.frame.size.width /2,60*ScaleWidth);
                [oneBtn addSubview:[self getLineView:CGRectMake(CGRectGetMaxX(oneBtn.frame)-0.5,10*ScaleWidth, 0.5, oneBtn.frame.size.height-30*ScaleWidth)]];
            }
             alertView.frame = CGRectMake(30*ScaleWidth, 0, kScreen_Width-60*ScaleWidth, CGRectGetMaxY(twoBtn.frame));
        }
        //判断按钮大于2个的时候
       else{
           [_titleBtnArray removeAllObjects];
           for (int i = 0; i<buttonTitleArray.count; i++) {
               UIButton *titleBtn = [[UIButton alloc]init];
               titleBtn.frame = CGRectMake(0, (i*60*ScaleWidth)+CGRectGetMaxY(massageLabel.frame)+15*ScaleWidth, massageLabel.frame.size.width,60*ScaleWidth);
               [titleBtn setTitle:buttonTitleArray[i] forState:(UIControlStateNormal)];
               [titleBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
               titleBtn.backgroundColor = [UIColor whiteColor];
               titleBtn.titleLabel.font = [UIFont systemFontOfSize:18*ScaleWidth];
               [titleBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18*ScaleWidth]];
               [titleBtn addSubview:[self getLineView:CGRectMake(0, 0, massageLabel.frame.size.width, 0.5*ScaleWidth)]];
               titleBtn.tag = i;
               [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
               [_titleBtnArray addObject:titleBtn];

               [alertView addSubview:titleBtn];
               alertView.frame = CGRectMake(30*ScaleWidth, 0, kScreen_Width-60*ScaleWidth, CGRectGetMaxY(titleBtn.frame));
           }
       }
        _aletView = alertView;
    }

    return self;
}

#pragma mark －－显示在控制器中
-(void)show{
    [UIView animateWithDuration:0.2 animations:^{
    _aletView.frame = CGRectMake(30*ScaleWidth, kScreen_Height/2-_aletView.frame.size.height/2, _aletView.frame.size.width, _aletView.frame.size.height);
    }];

    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
}

#pragma mark －－获取文字方法
-(CGRect)getStrimgRect:(NSString *)str andWithStringFontSize:(NSInteger)font andWithCurrentProlWitch:(CGFloat)witch{
    CGSize  maxSize;
    maxSize = CGSizeMake(witch,MAXFLOAT);
    CGRect rect=
    [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName,nil]context:nil];

    return rect;
}

#pragma mark －－创建灰色线
-(UIView*)getLineView:(CGRect)rect{
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = rect;
    lineView.backgroundColor = [UIColor grayColor];
    return lineView;
}

#pragma mark  －－按钮点击方法
-(void)titleBtnClick:(UIButton*)btn{
    [self removeFromSuperview];
    self.resultIndex(btn.tag,self.tag);
}

#pragma mark －－设置按钮背景颜色－－设置按钮文字颜色
-(void)setTitleBtnWithBgColor:(UIColor *)bgColor andWithtitleColor:(UIColor *)titleColor atBtnTag:(NSInteger)tag{
    if (tag <_titleBtnArray.count) {
        UIButton *btn = _titleBtnArray[tag];
        
        if (bgColor != nil) {
             btn.backgroundColor = bgColor;
        }
        if (titleColor != nil) {
            [btn setTitleColor:titleColor forState:(UIControlStateNormal)];
        }
    }else{
        NSLog(@"并没有创建tag相对应的btn");
    }
}

#pragma mark －－设置标题文字颜色
-(void)setTitleTextColorr:(UIColor *)textColor{
    if (textColor != nil) {
        _titleLabel.textColor = textColor;
    }
}


#pragma mark －－设置信息文字颜色
-(void)setMassageTextColor:(UIColor *)textColor {
       if (textColor != nil) {
        _massageLabel.textColor = textColor;
    }
}

#pragma mark －－设置背景颜色
-(void)setAlertViewBgColor:(UIColor*)bgColor{
    if (bgColor != nil) {
        _aletView.backgroundColor = bgColor;
    }
}
@end
