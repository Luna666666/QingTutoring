//
//  IdentyInfoCollectionViewCell.h
//  QingTutoring
//
//  Created by Charles on 2019/1/18.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IdentyInfoCollectionViewCell;
@protocol SelectModIdentyInfoViewDelegate <NSObject>
/**
 @param cell IdentyInfoCollectionViewCell
 @param sender 点击当前按钮
 */
-(void)selectModIdentyInfoCollectionViewCell:(IdentyInfoCollectionViewCell*)cell didClickAction:(UIButton*)sender;
@end

@interface IdentyInfoCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic) UIButton *gradeBtn;
@property (nonatomic, weak) id<SelectModIdentyInfoViewDelegate>delegate;//设置委托

@end

