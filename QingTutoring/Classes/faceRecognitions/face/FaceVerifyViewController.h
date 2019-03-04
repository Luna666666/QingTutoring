//
//  FaceVerifyViewController.h
//  IFlyMFVDemo
//
//  Created by 张剑 on 15/5/18.
//
//

#import <UIKit/UIKit.h>

#import "iflyMSC/IFlyMSC.h"

@interface FaceVerifyViewController : UIViewController

@property (nonatomic, retain)  UIImageView *imageView;
@property (nonatomic, retain)  UIImage*  face;
@property (nonatomic, strong)  UILabel*  authIdLabel;
@property (nonatomic, strong)  UIButton* faceBtn;
@property (nonatomic, strong)  UIButton* queryBtn;
@property (nonatomic, strong)  UIButton* enrollBtn;
@property (nonatomic, strong)  UIButton* delBtn;
@property (nonatomic, strong)  UIPopoverController *popover;
//所有操作不支持并发执行，需要触发限制
@property (nonatomic, retain)  UIActivityIndicatorView *activityIndicator;

@end
