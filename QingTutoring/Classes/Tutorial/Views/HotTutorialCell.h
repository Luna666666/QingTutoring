//
//  HotTutorialCell.h
//  QingTutoring
//
//  Created by Charles on 2019/1/30.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tutorial.h"
NS_ASSUME_NONNULL_BEGIN

@interface HotTutorialCell : UITableViewCell
@property (nonatomic, strong)Tutorial *model;
@end

NS_ASSUME_NONNULL_END
