//
//  IdentityInformationViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/17.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "IdentityInformationViewController.h"
#import "IdentyInfoCollectionViewCell.h"
#import "IdentyInfoHeadView.h"
#import "identifyModel.h"
#import "IdentyInfoFootView.h"
#import "LoginViewController.h"

@interface IdentityInformationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SelectModIdentyInfoViewDelegate>
@property(strong,nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong)IdentyInfoHeadView *heardView;//头部视图
@property(strong,nonatomic) NSMutableArray *modIdentifyArray;//item数组
@property(strong,nonatomic) UIButton *finishBtn;
@property(strong,nonatomic) UIButton *selectBtn;
@end

@implementation IdentityInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写身份信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:18],NSForegroundColorAttributeName:[UIColor colorWithHex:@"#101010"] }];
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self requestIdentifyItemData];
}
-(void)createUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,NavigateBarH+10,SCREEN_WIDTH,SCREEN_HEIGHT-64-49-10) collectionViewLayout:flowLayout];
    self.collectionView.userInteractionEnabled=YES;
    [self.collectionView registerClass:[IdentyInfoCollectionViewCell class] forCellWithReuseIdentifier:@"identyInfoCollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[IdentyInfoHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [self.collectionView registerClass:[IdentyInfoFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    [self.view addSubview:self.collectionView];
    
    self.finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.frame= CGRectMake(10,CGRectGetMaxY(self.collectionView.frame),SCREEN_WIDTH-20,40);
    self.finishBtn.clipsToBounds = YES;
    self.finishBtn.layer.cornerRadius = 4;
    [self.finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.finishBtn.backgroundColor = [UIColor colorWithHex:@"#3BAEFD"];
    [self.finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.finishBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
    [self.view addSubview:self.finishBtn];
    
}
#pragma mark--请求班级信息
-(void)requestIdentifyItemData{
    self.modIdentifyArray = [NSMutableArray arrayWithArray: @[@[@"学生",@"家长", @"辅导班"],@[],@[@"一年级",@"二年级", @"三年级",@"四年级",@"五年级",@"六年级"], @[@"七年级",@"八年级", @"九年级"], @[@"高一",@"高二", @"高三"]]];
    [self.collectionView reloadData];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.modIdentifyArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return [self.modIdentifyArray[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IdentyInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identyInfoCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.delegate = self;
    [cell.gradeBtn setTitle:[NSString stringWithFormat:@"%@",self.modIdentifyArray[indexPath.section][indexPath.row]] forState:UIControlStateNormal];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
     UICollectionReusableView *reusable = nil;
    NSArray * modIdentifySectionArray = @[@"请选择您的身份以提供最佳服务",@"请选择您的年级",@"小学",@"初中",@"高中"];
    if (kind == UICollectionElementKindSectionHeader) {
        self.heardView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        self.heardView.selectIdentyLB.text = [NSString stringWithFormat:@"%@",modIdentifySectionArray[indexPath.section]];
        if (indexPath.section == 0 ||indexPath.section == 1) {
            self.heardView.selectIdentyLB.font = [UIFont systemFontOfSize:13];
            self.heardView.underSelectLine.hidden = NO;
        }
        reusable =self.heardView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        IdentyInfoFootView *foot =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            foot.identyFootView.hidden = NO;
        }
        reusable = foot;
    }
     return reusable;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - SelectModIdentyInfoViewDelegate
-(void)selectModIdentyInfoCollectionViewCell:(IdentyInfoCollectionViewCell*)cell didClickAction:(UIButton*)sender{
    if(self.selectBtn == sender){
        return;
    }
    if (self.selectBtn != nil){
        self.selectBtn.selected = NO;
        self.selectBtn.layer.borderColor = [UIColor colorWithHex:@"#101010"].CGColor;
        [self.selectBtn setTitleColor:[UIColor colorWithHex:@"#101010"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    sender.layer.borderColor = [UIColor colorWithHex:@"#3BAEFD"].CGColor;
    [sender setTitleColor:[UIColor colorWithHex:@"#3BAEFD"] forState:UIControlStateNormal];
    self.selectBtn = sender;
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:-0.1 *  M_PI]; // 开始时的角度
    animation.toValue = [NSNumber numberWithFloat:0.1 * M_PI]; // 结束时的角度
    animation.duration = 0.2;
    animation.repeatCount = 1;
    animation.autoreverses = true;
    [sender.layer addAnimation:animation forKey:@"rotate-layer"];
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 100) / 3,50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5,10,2,10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
     return CGSizeMake(SCREEN_WIDTH,37);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH,10);
}
#pragma mark--btnClicked
-(void)finishBtnClicked:(UIButton*)sender{
     LoginViewController * loginVC = [[LoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
//班级信息
-(NSMutableArray*)modIdentifyArray{
    if (!_modIdentifyArray) {
        _modIdentifyArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _modIdentifyArray;
}
@end
