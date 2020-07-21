
#import "LRViewController.h"
#import "LRUISize.h"

#define kNavigationTitleMaxLength (kUIWidth - 180)

static UIImage *defaultImage = nil;
static NSString *defaultImageName = nil;
static NSMutableDictionary *navigationBarBackgroundImageDictionary = nil;

@interface LRViewController ()

@end

@implementation LRViewController

-(instancetype)init{
    if (self=[super init]) {
        
        if (@available(iOS 13.0, *)) {
            self.modalPresentationStyle = UIModalPresentationFullScreen ;
            [self setValue:@YES forKey:@"modalInPresentation"];
        }
        
        [self.navigationItem setHidesBackButton:YES animated:NO];
        self.interactivePopGestureRecognizerEnabled = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarDefaultBackgroundImage];
    [self.navigationItem setHidesBackButton:YES];
    if (!_customNavigationBarHiddenWhenAppear) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewAppearTime = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configBaseUI];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)configBaseUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setExclusiveTouch:YES];

    if (@available(iOS 13.0, *)) {
        self.modalPresentationStyle = UIModalPresentationFullScreen ;
        [self setValue:@YES forKey:@"modalInPresentation"];
    }
}

#pragma mark - 设置导航条

- (void)setNavigationBarLeftItems:(NSArray *)leftItems
{
    NSAssert(leftItems.count, @"左侧按钮数组非空");
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:leftItems.count];
    for (UIView *view in leftItems) {
        if ([view isKindOfClass:[UIBarButtonItem class]]) {
            [items addObject:view];
        }else{
            view.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:view];
            [items addObject:left];
        }
    }
    self.navigationItem.leftBarButtonItems = items;
}

-(void)createLeftBtnItemWithCustomView:(UIView*)customView{
    [self setNavigationBarLeftItems:[NSArray arrayWithObject:customView]];
}

UIButton *DefaultLeftButton(NSInteger fontSize, UIColor *normalColor, UIColor *highlightColor)
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"LRImage.bundle/LRBackImageBlack"] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    if (fontSize > 0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    if (normalColor) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (highlightColor) {
        [btn setTitleColor:highlightColor forState:UIControlStateHighlighted];
    }
    return btn;
}

//导航栏自带返回
-(void)createLeftBtnItem{
    self.navLeftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.navLeftBtn.frame = CGRectMake(0, 0, 44, 44);
    self.navLeftBtn.tag=1001;
    [self.navLeftBtn setImage:[UIImage imageNamed:@"LRImage.bundle/LRBackImageBlack"] forState:UIControlStateNormal];
    [self.navLeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.navLeftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self createLeftBtnItemWithCustomView:self.navLeftBtn];
}

-(void)removeNavigationBarLeftItems {
    self.navigationItem.leftBarButtonItems = nil;
}

- (void)leftAction:(UIButton *)btn
{
    //不设置返回代理，默认pop或dismiss
    if (self.baseNavDelegate && [self.baseNavDelegate respondsToSelector:@selector(goBackListener)]) {
        [self.baseNavDelegate goBackListener];
    }else {
        //加上这句有没有错误？？？
        if(self.presentedViewController)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)setNavigationBarRightItems:(NSArray *)rightItems
{
    NSAssert(rightItems.count, @"右侧按钮数组非空");
    NSArray *reverseRight = [[rightItems reverseObjectEnumerator] allObjects];
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:reverseRight.count];
    for (UIView *view in reverseRight) {
        if ([view isKindOfClass:[UIBarButtonItem class]]) {
            [items addObject:view];
        }else{
            view.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
            UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:view];
            [items addObject:right];
        }
    }
    self.navigationItem.rightBarButtonItems = items;
}

-(void)createRightBtnItemWithCustomView:(UIView*)customView
{
    [self setNavigationBarRightItems:[NSArray arrayWithObject:customView]];
}

-(void)removeNavigationBarRightItems {
    self.navigationItem.rightBarButtonItems = nil;
}

-(void)setNavigationBarTitle:(NSString*)title font:(UIFont*)font color:(UIColor*)color
{
    NSString *pageTitle = title;
    
    if (font == nil) {
        font = [UIFont fontWithName:@"Helvetica-bold" size:17];
    }
    
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont fontWithName:font.fontName size:font.pointSize],NSKernAttributeName:@(0.2f)};
    CGSize titleSize = [pageTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.font = font;
    titleLabel.textColor = color;
    titleLabel.text = pageTitle;
    titleLabel.tag = 999;
    
    if (titleSize.width < kNavigationTitleMaxLength) {
        titleLabel.frame = CGRectMake((kUIWidth - titleSize.width) / 2, (44 - titleSize.height) / 2, titleSize.width, titleSize.height);
    }else{
        titleLabel.frame = CGRectMake((kUIWidth - kNavigationTitleMaxLength) / 2, (44 - titleSize.height) / 2, kNavigationTitleMaxLength, titleSize.height);
    }
    
    [self createTitleView:titleLabel];
}

-(void)createTitleView:(UIView*)titleView
{
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = titleView;
    if (!self.navigationItem.title.length) {
        self.navigationItem.title = @"";
    }
}

#pragma mark -- 设置导航条背景色

- (void)setNavigationBarDefaultBackgroundImage {
    [self.navigationController.navigationBar setBackgroundImage:defaultImage forBarMetrics:UIBarMetricsDefault];
}

- (void)revertNavigationBarDefaultBackgroundImage
{
    if (defaultImage) {
        defaultImage = RefactorImage(defaultImage, CGSizeMake(kUIWidth, kNavigationBarHeight + kStatusBarHeight));
    }else{
        UIImage *image = [UIImage imageNamed:defaultImageName];
        if (image == nil) {
            image = [UIImage imageNamed:@"LRImage.bundle/LRNavigationBarWhite"];
        }
        defaultImage = RefactorImage(image, CGSizeMake(kUIWidth, kNavigationBarHeight + kStatusBarHeight));
    }
    if (defaultImage) {
        [self setNavigationBarDefaultBackgroundImage];
    }
}

- (void)setNavigationBarClearBackgroundImage {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

+ (void)configureDefaultNavigationBarBackgroundImage:(NSString *)imageName
{
    defaultImageName = imageName;
    UIImage *image = [UIImage imageNamed:imageName];
    if (image == nil) {
        image = [UIImage imageNamed:@"LRImage.bundle/LRNavigationBarWhite"];
    }
    defaultImage = RefactorImage(image, CGSizeMake(kUIWidth, kNavigationBarHeight + kStatusBarHeight));
}

#pragma mark - 结束
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.viewDisappearTime = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

- (void)controllerPopByInteractivePopGestureRecognizer{}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
