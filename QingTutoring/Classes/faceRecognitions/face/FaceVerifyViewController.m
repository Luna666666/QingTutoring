//
//  FaceVerifyViewController.m
//  IFlyMFVDemo
//
//  Created by 张剑 on 15/5/18.
//
//

#import "FaceVerifyViewController.h"
#import "UIView+Toast.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "Definition.h"
#import "UIImage+Extensions.h"
#import "UserManager.h"
#import "PermissionDetector.h"
#import "ErrorManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>
@interface FaceVerifyViewController()<IFlyIdentityVerifierDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPopoverControllerDelegate>
@property (nonatomic, retain)IFlyIdentityVerifier *identityVerifier;

@end


@implementation FaceVerifyViewController

@synthesize identityVerifier;

-(instancetype)init{
    if(self=[super init]){
        identityVerifier=[IFlyIdentityVerifier sharedInstance];
        self.identityVerifier.delegate=self;
    }
    return self;
}

-(void)dealloc{
    self.identityVerifier.delegate=nil;
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView{
    [super loadView];
    //adjust the UI for iOS 7
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER ){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *mainView = [[UIView alloc] initWithFrame:frame];
    mainView.backgroundColor = [UIColor blackColor];
    self.view = mainView;
    
    //title
    self.title = @"人脸识别";
    
    //image
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame=CGRectMake(Padding,Margin*2,(self.view.frame.size.width-Padding*2),(self.view.frame.size.height-Padding*4)/2);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    UIImage* image=[[UserManager currentUser] image];
    imageView.image=[UIImage imageNamed:@"default.png"];
//    if(image){
//        self.face=[[image fixOrientation] compressedImage];//将图片压缩以上传服务器
//    }
    self.imageView=imageView;
    [[self view] addSubview:imageView];
    
    //info bar
    UIImageView* userImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user"]];
    userImgView.frame = CGRectMake(Padding*2, imageView.frame.origin.y+imageView.frame.size.height+Margin*2+ButtonHeight/3, ButtonHeight/3, ButtonHeight/3);
    [[self view] addSubview:userImgView];
    
    UILabel *authIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding*2+ButtonHeight/2+Margin, imageView.frame.origin.y+imageView.frame.size.height+Margin*2+ButtonHeight/4, (self.view.frame.size.width-Padding*4-ButtonHeight/2), ButtonHeight/2)];
    [authIdLabel setBackgroundColor:[UIColor clearColor]];
    UIFont* font=[UIFont systemFontOfSize:17.0f];
    [authIdLabel setFont:font];
    [authIdLabel setTextColor:[UIColor whiteColor]];
    [authIdLabel setTextAlignment:NSTextAlignmentLeft];
    NSString* authId=[[UserManager currentUser] authID];
    authIdLabel.text=[NSString stringWithFormat:@"%@",@"silence8889"];
    self.authIdLabel=authIdLabel;
    [[self view] addSubview:authIdLabel];
    

    //select image
    UIButton* faceBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    faceBtn.layer.cornerRadius=10;
    [faceBtn setTitle:@"更换图片" forState:UIControlStateNormal];
     [faceBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
     faceBtn.backgroundColor = [UIColor blueColor];
    faceBtn.frame = CGRectMake(Padding, authIdLabel.frame.origin.y+authIdLabel.frame.size.height+Margin*2, (self.view.frame.size.width-Padding*3)/2, ButtonHeight);
    [faceBtn addTarget:self action:@selector(onBtnFace:) forControlEvents:UIControlEventTouchUpInside];
    self.faceBtn = faceBtn;
    [self.view addSubview:faceBtn];
    
    //query
    UIButton* queryBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    queryBtn.layer.cornerRadius=10;
    queryBtn.backgroundColor = [UIColor blueColor];
    [queryBtn setTitle:@"验证模型" forState:UIControlStateNormal];
     [queryBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    queryBtn.frame = CGRectMake((self.view.frame.size.width-Padding*3)/2+Padding*2, authIdLabel.frame.origin.y+authIdLabel.frame.size.height+Margin*2, (self.view.frame.size.width-Padding*3)/2, ButtonHeight);
    [queryBtn addTarget:self action:@selector(onBtnQuery:) forControlEvents:UIControlEventTouchUpInside];
    self.queryBtn = queryBtn;
    [self.view addSubview:queryBtn];
    
    //enroll验证模型
    UIButton* enrollBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    enrollBtn.layer.cornerRadius=10;
    enrollBtn.backgroundColor = [UIColor blueColor];
    [enrollBtn setTitle:@"注册模型" forState:UIControlStateNormal];
    [enrollBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    enrollBtn.frame = CGRectMake(Padding, queryBtn.frame.origin.y+queryBtn.frame.size.height+Margin*2, (self.view.frame.size.width-Padding*3)/2, ButtonHeight);
    [enrollBtn addTarget:self action:@selector(onBtnEnroll:) forControlEvents:UIControlEventTouchUpInside];
    self.enrollBtn = enrollBtn;
    [self.view addSubview:enrollBtn];
    
    //delete删除模型
    UIButton* delBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    delBtn.layer.cornerRadius=10;
    delBtn.backgroundColor = [UIColor blueColor];
    [delBtn setTitle:@"删除模型" forState:UIControlStateNormal];
     [delBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    delBtn.frame = CGRectMake((self.view.frame.size.width-Padding*3)/2+Padding*2, queryBtn.frame.origin.y+queryBtn.frame.size.height+Margin*2, (self.view.frame.size.width-Padding*3)/2, ButtonHeight);
    [delBtn addTarget:self action:@selector(onBtnDel:) forControlEvents:UIControlEventTouchUpInside];
    self.delBtn = delBtn;
    [self.view addSubview:delBtn];
    
    //activity
    UIActivityIndicatorView* activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    [activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleBottomMargin;
    activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator=activityIndicator;
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator stopAnimating];
    [self.view addSubview:activityIndicator];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.identityVerifier cancel];
}

#pragma mark - refresh

- (void)refreshPopupInfo:(NSString*)info{
    if(info){
        [self.activityIndicator stopAnimating];
        [self.faceBtn setEnabled:YES];
        [self.enrollBtn setEnabled:YES];
        [self.queryBtn setEnabled:YES];
        [self.delBtn setEnabled:YES];
        
        [self.view makeToast:info duration:3.0 position:CSToastPositionTop];
    }
}

- (void)refreshErrorInfo:(IFlySpeechError*)error{
    [self.activityIndicator stopAnimating];
    [self.faceBtn setEnabled:YES];
    [self.enrollBtn setEnabled:YES];
    [self.queryBtn setEnabled:YES];
    [self.delBtn setEnabled:YES];
    
    NSString* info=[NSString stringWithFormat:@"错误码:%d",error.errorCode];
    [self.view makeToast:info duration:3.0 position:CSToastPositionTop];
    
}

- (void)presentImagePicker:(UIImagePickerController* )picker{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        self.popover=[[UIPopoverController alloc] initWithContentViewController:picker];
        self.popover.delegate=self;
        [self.popover presentPopoverFromRect:self.faceBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:NO];
        }
    else{
        if(!picker){
            return;
        }
        
        [self presentViewController:picker animated:NO completion:nil];
    }
}

#pragma mark - actions

- (void)onBtnFace:(id)sender{
    
    [self.faceBtn setEnabled:NO];
    [self.enrollBtn setEnabled:NO];
    [self.queryBtn setEnabled:NO];
    [self.delBtn setEnabled:NO];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"图片获取方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"摄像机",@"图片库", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    
    actionSheet.alpha = 1.f;
    actionSheet.tag = 1;
    UIView *bgView=[[UIView alloc] initWithFrame:actionSheet.frame];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [actionSheet addSubview:bgView];
    [actionSheet showInView:self.view];
}
//注册模型
- (void)onBtnEnroll:(id)sender{
    if(!self.face){
        [self refreshPopupInfo:@"请先选择照片"];
        return;
    }
    
    [self.identityVerifier cancel];
    [self.activityIndicator startAnimating];
    [self.faceBtn setEnabled:NO];
    [self.enrollBtn setEnabled:NO];
    [self.queryBtn setEnabled:NO];
    [self.delBtn setEnabled:NO];

    [self.identityVerifier setParameter:nil forKey:[IFlySpeechConstant PARAMS]];
    // 人脸参数
    // 设置sub 参数请求业务类型
    [self.identityVerifier setParameter:@"mfv" forKey:[IFlySpeechConstant MFV_SUB]];
    // 指明注册的特征种类
    [self.identityVerifier setParameter:@"ifr" forKey:[IFlySpeechConstant MFV_SCENES]];
    [self.identityVerifier setParameter:@"gen" forKey:@"scene_mode"];
    // 设置delegate ,auth_id，开始会话
    NSString* auth_id=self.authIdLabel.text;
    [self.identityVerifier setParameter:@"enroll" forKey:[IFlySpeechConstant MFV_SST]];
    [self.identityVerifier setParameter:auth_id forKey:[IFlySpeechConstant MFV_AUTH_ID]];
    [self.identityVerifier startWorking];
    
    // 人脸数据参数
    NSString* dwtParams=[NSString stringWithFormat:@"%@=%@,",[IFlySpeechConstant MFV_SST],@"enroll"];
    dwtParams=[dwtParams stringByAppendingFormat:@"%@=%@,",[IFlySpeechConstant MFV_AUTH_ID],auth_id];

//    NSData* data= UIImageJPEGRepresentation(self.face, 1.0);
    // 压缩人脸数据并写入
    NSData* data=[self.face compressedData];
    [self.identityVerifier write:@"ifr" data:data offset:0 length:(int)[data length] withParams:dwtParams];
    [self.identityVerifier stopWrite:@"ifr"];
}

//验证模型
- (void)onBtnQuery:(id)sender{
    
    if(!self.face){
        [self refreshPopupInfo:@"请先选择照片"];
        return;
        
    }
    
    [self.identityVerifier cancel];
    [self.activityIndicator startAnimating];
    [self.faceBtn setEnabled:NO];
    [self.enrollBtn setEnabled:NO];
    [self.queryBtn setEnabled:NO];
    [self.delBtn setEnabled:NO];
    
    [self.identityVerifier setParameter:nil forKey:[IFlySpeechConstant PARAMS]];
    [self.identityVerifier setParameter:@"mfv" forKey:[IFlySpeechConstant MFV_SUB]];
    // 设置会话场景
    [self.identityVerifier setParameter:@"ifr" forKey:[IFlySpeechConstant MFV_SCENES]];
    // 设置会话场景
    [self.identityVerifier setParameter:@"verify" forKey:[IFlySpeechConstant MFV_SST]];
    [self.identityVerifier setParameter:@"sin" forKey:[IFlySpeechConstant MFV_VCM]];
    [self.identityVerifier setParameter:@"vfy" forKey:@"scene_mode"];
    // 用户id
    NSString* auth_id=self.authIdLabel.text;
    [self.identityVerifier setParameter:auth_id forKey:[IFlySpeechConstant MFV_AUTH_ID]];
    // 人脸数据参数
    NSString* dwtParams=[NSString stringWithFormat:@"%@=%@,",[IFlySpeechConstant MFV_AUTH_ID],auth_id];
    dwtParams=[dwtParams stringByAppendingFormat:@"%@=%@,",[IFlySpeechConstant MFV_SST],@"verify"];
    
    [self.identityVerifier startWorking];
//    NSData* data= UIImageJPEGRepresentation(self.face, 1.0);
    // 压缩人脸数据并写入
    NSData* data=[self.face compressedData];
    [self.identityVerifier write:@"ifr" data:data offset:0 length:(int)[data length] withParams:dwtParams];
    [self.identityVerifier stopWrite:@"ifr"];
}
//人脸删除
- (void)onBtnDel:(id)sender{
    [self.identityVerifier cancel];
    
    [self.activityIndicator startAnimating];
    [self.faceBtn setEnabled:NO];
    [self.enrollBtn setEnabled:NO];
    [self.queryBtn setEnabled:NO];
    [self.delBtn setEnabled:NO];
    
    [self.identityVerifier setParameter:nil forKey:[IFlySpeechConstant PARAMS]];
    [self.identityVerifier setParameter:@"mfv" forKey:[IFlySpeechConstant MFV_SUB]];
    // 设置会话场景
    [self.identityVerifier setParameter:@"ifr" forKey:[IFlySpeechConstant MFV_SCENES]];
    [self.identityVerifier setParameter:@"gen" forKey:@"scene_mode"];
    // 用户id
    NSString* auth_id=self.authIdLabel.text;
    [self.identityVerifier setParameter:auth_id forKey:[IFlySpeechConstant MFV_AUTH_ID]];
    
    // 人脸数据参数
    NSString* dwtParams=[NSString stringWithFormat:@"%@=%@,",[IFlySpeechConstant MFV_AUTH_ID],auth_id];
    
    [self.identityVerifier execute:@"ifr" cmd:@"delete" params:dwtParams];
}


- (void)btnExploerClicked:(id)sender {
    
    if(![PermissionDetector isAssetsLibraryPermissionGranted]){
        NSString* info=@"没有相机权限";
        [self refreshPopupInfo:info];
        return;
    }
    
    _faceBtn.enabled=NO;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    if([UIImagePickerController isSourceTypeAvailable: picker.sourceType ]) {
        picker.mediaTypes = @[(NSString*)kUTTypeImage];
        picker.delegate = self;
        picker.allowsEditing = NO;
    }
    
    [self performSelector:@selector(presentImagePicker:) withObject:picker ];
}

- (void)btnPhotoClicked:(id)sender {
    
    if(![PermissionDetector isCapturePermissionGranted]){
        NSString* info=@"没有相册权限";
        [self refreshPopupInfo:info];
        return;
    }
    
    _faceBtn.enabled=NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
        picker.mediaTypes = @[(NSString*)kUTTypeImage];
        picker.allowsEditing = NO;//Set editable
        picker.delegate = self;
        
        [self performSelector:@selector(presentImagePicker:) withObject:picker];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设备不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        _faceBtn.enabled=YES;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [actionSheet resignFirstResponder];
    switch (actionSheet.tag){
        case 1:
            switch (buttonIndex){
            case 0:{
                [self btnPhotoClicked:nil];
            }
                break;
            case 1:{
                [self btnExploerClicked:nil];
            }
                break;
            default:{
                [self.faceBtn setEnabled:YES];
                [self.enrollBtn setEnabled:YES];
                [self.queryBtn setEnabled:YES];
                [self.delBtn setEnabled:YES];
            }
                break;
        }
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _face = [[image fixOrientation] compressedImage];//Compress the picture to upload the server
    _imageView.image=_face;
    [[UserManager currentUser] setImage:image];
    [self.faceBtn setEnabled:YES];
    [self.enrollBtn setEnabled:YES];
    [self.queryBtn setEnabled:YES];
    [self.delBtn setEnabled:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.faceBtn setEnabled:YES];
    [self.enrollBtn setEnabled:YES];
    [self.queryBtn setEnabled:YES];
    [self.delBtn setEnabled:YES];

}

#pragma mark - UIPopoverControllerDelegate
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    [self.faceBtn setEnabled:YES];
    [self.enrollBtn setEnabled:YES];
    [self.queryBtn setEnabled:YES];
    [self.delBtn setEnabled:YES];
    return YES;
}

#pragma mark - IFlyIdentityVerifierDelegate
/*!
 *  error callback
 *
 *  @param error 错误描述类
 */
- (void)onCompleted:(IFlySpeechError *)error{
    if(!error){
        return;
    }

    NSLog(@"error:%d",error.errorCode);
    [self performSelectorOnMainThread:@selector(refreshErrorInfo:) withObject:error waitUntilDone:NO];
}

/*!
 *  result callback
 *
 *  @param results -[out] 结果。
 *  @param isLast  -[out] 是否最后一条结果
 */
- (void)onResults:(IFlyIdentityResult *)results isLast:(BOOL)isLast{
    
    NSLog(@"results:%@ islast:%@",[results result],isLast?@"YES":@"NO");
    
    NSDictionary* dicResult=[results dictionaryResults];
    if(!dicResult){
        return;
    }
    
    NSString* sub=[dicResult objectForKey:@"ssub"];
    NSString* sst=[dicResult objectForKey:@"sst"];
    NSString* ret=[dicResult objectForKey:@"ret"];
    
    // Non face service non processing
    if(!sub || ![sub isEqualToString:@"ifr"] ){
        return;
    }
    
    if(!ret){
        return;
    }
    
    int errorCode=[ret intValue];
    if(errorCode){
        NSLog(@"results: err:%d",errorCode);
        IFlySpeechError* error=[IFlySpeechError initWithError:errorCode];
//        error.errorDesc=[ErrorManager errorDescForCode:errorCode];
        [self performSelectorOnMainThread:@selector(refreshErrorInfo:) withObject:error waitUntilDone:NO];
        return;

    }
    
    NSString* info=nil;
    if([sst isEqualToString:@"enroll"]){
       info=@"注册成功";
    }
    else if([sst isEqualToString:@"delete"]){
       info=@"删除成功";
    }
    else if([sst isEqualToString:@"verify"]){
        NSString* decision=[dicResult objectForKey:@"decision"];
        if ([decision isEqualToString:@"accepted"]) {
            info=@"验证成功";
        }
        else {
            info=@"验证失败";
        }
    }
    
    [self performSelectorOnMainThread:@selector(refreshPopupInfo:) withObject:info waitUntilDone:NO];
}

/**
 *  扩展接口，用于抛出音量和vad_eos消息
 *
 *  @param eventType 消息类型
 *  @param arg1      eventType为 Event_volume 时 arg1为音量值
 *  @param arg2      参数2
 *  @param obj       扩展参数
 */
- (void)onEvent:(int)eventType arg1:(int)arg1 arg2:(int)arg2 extra:(id)obj{
    NSLog(@"onEvent:%d arg1:%d arg2:%d obj:%@",eventType,arg1,arg2,obj);
}


@end
