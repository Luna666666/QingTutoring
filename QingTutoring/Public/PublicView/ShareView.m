//
//  ShareView.m
//  Nplan
//
//  Created by Ponfey on 2016/12/27.
//  Copyright © 2016年 thirdnet. All rights reserved.
//

#import "ShareView.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>

@interface ShareView ()

@property (nonatomic, copy) SuccessHandle success;
@property (nonatomic, strong) UIView *translucentView;
@property (nonatomic, strong) NSArray *titleLabelArray;
@property (nonatomic, assign) CGFloat shareViewHeight;

@end

@implementation ShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor blackColor];
    self.translucentView = [[UIView alloc] init];
    self.translucentView.backgroundColor = [UIColor blackColor];
    self.translucentView.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.translucentView addGestureRecognizer:tap];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:_translucentView];
    [window addSubview:self];
    
    [self.translucentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    NSMutableArray *titleArray = [NSMutableArray array];
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]) {
        [titleArray addObject:@"微信"];
        [titleArray addObject:@"朋友圈"];
    }
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
        [titleArray addObject:@"手机QQ"];
        [titleArray addObject:@"QQ空间"];
    }
    self.shareViewHeight = titleArray.count > 4 ? 270 : 180;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(window);
        make.top.equalTo(window.mas_bottom);
        make.height.mas_equalTo(_shareViewHeight);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setBackgroundColor:MainColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 3;
    cancelBtn.layer.masksToBounds = YES;
    [self addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.bottom.equalTo(self).offset(-20);
        make.height.mas_equalTo(36);
        
    }];
    
    if (titleArray.count == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = SubTitleColor;
        label.text = @"未安装支持的客户端，请安装QQ/微信后使用该功能。";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.top.equalTo(self).offset(42);
        }];
        return;
    }
    
    CGFloat itemWidth = SCREEN_WIDTH / 4;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i <titleArray.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:[UIImage imageNamed:titleArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        NSString *type = titleArray[i];
        if ([type isEqualToString:@"微信"]) {
            btn.tag = 1;
        } else if ([type isEqualToString:@"朋友圈"]) {
            btn.tag = 2;
        } else if ([type isEqualToString:@"手机QQ"]) {
            btn.tag = 3;
        }else if ([type isEqualToString:@"QQ空间"]) {
            btn.tag = 5;
        }
        [self addSubview:btn];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = SubTitleColor;
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        [tempArray addObject:label];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).offset(itemWidth / 2 + itemWidth * (i % 4));
            make.centerY.equalTo(self.mas_top).offset(50 + 90 * (i / 4));
            make.width.height.mas_equalTo(50);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.top.equalTo(btn.mas_bottom).offset(10);
        }];
    }
    self.titleLabelArray = tempArray;
}

- (void)showWithSuccess:(SuccessHandle)success {
    [UIView animateWithDuration:0.3 animations:^{
        self.translucentView.alpha = 0.3;
        self.transform = CGAffineTransformMakeTranslation(0, -_shareViewHeight);
    }];
    self.success = success;
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.translucentView.alpha = 0;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.translucentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)share:(UIButton *)button {
    SSDKPlatformType type = SSDKPlatformTypeUnknown;
    switch (button.tag) {
        case 1:
            type = SSDKPlatformSubTypeWechatSession;
            break;
        case 2:
            type = SSDKPlatformSubTypeWechatTimeline;
            break;
        case 3:
            type = SSDKPlatformSubTypeQQFriend;
            break;
        case 5:
            type = SSDKPlatformSubTypeQZone;
            break;
        default:
            break;
    }
    [ShareSDK share:type parameters:_shareInfo onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        if (state == SSDKResponseStateSuccess && self.success) {
            self.success();
        }
    }];
    [self hide];
}


- (void)setTitleColor:(UIColor *)titleColor {
    for (UILabel *label in _titleLabelArray) {
        label.textColor = titleColor;
    }
}

@end
