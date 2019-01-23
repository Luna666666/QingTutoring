#import "ViewManager.h"

@implementation ViewManager
//创建imageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame andImageName:(NSString *)imageName
{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];
    if(imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    return imageView;
}
//创建label
+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines textColor:(UIColor *)textColor
{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    if(title)
    {
        label.text=title;
    }
    if (font)
    {
        label.font=font;
    }
    
    label.textAlignment=alignment;
    label.numberOfLines=numberOfLines;
    
    if(textColor)
    {
        label.textColor=textColor;
    }
    return label;
}

+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font
{
    UILabel *label=[self createLabelFrame:frame title:title font:font textAlignment:NSTextAlignmentCenter numberOfLines:1 textColor:[UIColor whiteColor]];
    return label;
}
//创建按钮
+(UIButton *)createBtnWithFrame:(CGRect)frame andTitle:(NSString *)title andBgImageName:(NSString *)imageName andTarget:(id)target andAction:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if(title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if(imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if(target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
@end