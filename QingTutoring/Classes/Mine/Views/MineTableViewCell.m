//
//  MineTableViewCell.m
//  QingTutoring
//
//  Created by Charles on 2019/1/24.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell{
    UIImageView *_itemIcon;//图片
    UILabel *_itemTitle;//课程名称
    UIImageView *_detail;//图片
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        _itemIcon = [UIImageView new];
        _itemIcon.frame=CGRectMake(22,15,20,20);
        _itemIcon.contentMode=UIViewContentModeScaleAspectFill;
        _itemIcon.clipsToBounds = YES;
        _itemIcon.image=[UIImage imageNamed:@"mine_coupon"];
        [self addSubview:_itemIcon];
        
        _itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_itemIcon.frame)+20,10,200, 30)];
        _itemTitle.backgroundColor = [UIColor clearColor];
        _itemTitle.textColor =[UIColor colorWithHex:@"#101010"];
        _itemTitle.numberOfLines =1;
        _itemTitle.font = [UIFont systemFontOfSize:14];
        [self addSubview:_itemTitle];
        
        _detail = [UIImageView new];
        _detail.frame=CGRectMake(SCREEN_WIDTH-30,17.5,15,15);
        _detail.contentMode=UIViewContentModeScaleAspectFill;
        _detail.image=[UIImage imageNamed:@"mine_arrow"];
        [self addSubview:_detail];
        
    }
    return self;
}


@end
