#import "QingTutoringNavigationController.h"

@interface QingTutoringNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation QingTutoringNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak QingTutoringNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate =  weakSelf;
        
    }
}
-(BOOL)validateNumber:(NSString*)number {
    BOOL res = NO;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length != 0 &&(0<=[string intValue]<=23)) {
            res = YES;
            break;
        }
            i++;
            }
            return res;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated == YES ){
        
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated

{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]&& animated == YES ){
        
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
    return [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        if (navigationController.childViewControllers.count == 1) {
            
            self.interactivePopGestureRecognizer.enabled = NO;
            
        }else
            
            self.interactivePopGestureRecognizer.enabled = YES;
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.interactivePopGestureRecognizer.delegate = nil;
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL ok = YES; // 默认为支持右滑反回
    if ([self.topViewController isKindOfClass:[QingTutoringNavigationController class]]) {
        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
            QingTutoringNavigationController *vc = (QingTutoringNavigationController *)self.topViewController;
            ok = [vc gestureRecognizerShouldBegin];
        }
    }
    return ok;
}
- (BOOL)gestureRecognizerShouldBegin {
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
