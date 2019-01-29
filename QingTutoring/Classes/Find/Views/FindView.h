//
//  FindView.h
//  QingTutoring
//
//  Created by Charles on 2019/1/29.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindView : UIView<SDCycleScrollViewDelegate>
@property (nonatomic, strong)SDCycleScrollView * modFindCycleScrollView;//轮播图
@property (nonatomic, strong)ButtonWithTitle * hotTutorial;//热门辅导
@property (nonatomic, strong)ButtonWithTitle * moreTutorial;//更多辅导
@property(nonatomic, strong) NSMutableArray *cyclePictureArray;//轮播图片数组
@property (nonatomic,strong )NSArray *imageURLStringsGroup;//轮播图片数组
@property (nonatomic, copy)void(^MoreBtnClickBlock)(UIButton *moreBtn);
@end


