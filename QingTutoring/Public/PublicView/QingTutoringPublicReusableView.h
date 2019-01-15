//
//  QingTutoringPublicReusableView.h
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/30.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QingTutoringPublicReusableView;

@protocol SelectModQingTutoringPublicReusableViewDelegate <NSObject>
/**
 点击进入应用编辑
 @param view QingTutoringPublicReusableView
 @param sender 当前按钮
 */
-(void)selectModQingTutoringPublicReusableView:(QingTutoringPublicReusableView*)view modQingTutoringPublicReusableViewCenterAction:(id)sender;
@end

@interface QingTutoringPublicReusableView : UICollectionReusableView
@property(strong,nonatomic)UILabel *title;
@property(strong,nonatomic)UILabel *shuXian;
@property(strong,nonatomic)UILabel *dragTips;
@property(strong,nonatomic)UIButton *applicationEdit;
@property (nonatomic, weak) id<SelectModQingTutoringPublicReusableViewDelegate>delegate;

@end
