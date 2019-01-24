//
//  curriculumCell.h
//  QingTutoring
//
//  Created by Charles on 2019/1/23.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "curriculum.h"

NS_ASSUME_NONNULL_BEGIN

@interface curriculumCell : UITableViewCell
@property (nonatomic, strong)curriculum *model;
@end

NS_ASSUME_NONNULL_END
