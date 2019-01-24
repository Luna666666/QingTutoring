//
//  MineTableViewCell.h
//  QingTutoring
//
//  Created by Charles on 2019/1/24.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : UITableViewCell
/**
 item图标
 */
@property(nonatomic,strong)UIImageView *itemIcon;
/**
 
 图标标题
 */
@property(nonatomic,strong)UILabel *itemTitle;
/**
 
 图标详情
 */
@property(nonatomic,strong)UILabel *itemDetail;

@property(nonatomic,strong)UIView *grayLine;
/**
 item图标
 */
@property(nonatomic,strong)UIImageView *arrowDetail;
/**
 
 
 
 /**
 初始化ModJournalismStyle1Cell
 @param style UITableViewCellStyle
 @param reuseIdentifier 复用标志
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
