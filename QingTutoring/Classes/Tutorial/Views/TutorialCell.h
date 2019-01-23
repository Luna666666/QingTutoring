//
//  TutorialCell.h
//  QingTutoring
//
//  Created by Charles on 2019/1/23.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tutorial.h"

NS_ASSUME_NONNULL_BEGIN

@interface TutorialCell : UITableViewCell
@property (nonatomic, strong)Tutorial *model;
@end

NS_ASSUME_NONNULL_END
