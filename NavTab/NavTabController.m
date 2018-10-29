//
//  NavTabController.m
//  FMPlayer
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#define SCROLL_HEIGHT 667
#define SCROLL_WIDTH  375

#import "NavTabController.h"
#import "UIViewController+SharedViewController.h"
@interface NavTabController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) titleScrollView *titleView;

@end

@implementation NavTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleChange:) name:@"titleChange" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)createItemsWithFrame:(CGRect)frame andControllersArray:(NSArray *)controllersArray andTitlesArray:(NSArray *)titlesArray andTitleSize:(CGFloat)size andTitleStyle:(titleType)titleType andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor {
    
    self.view.userInteractionEnabled = YES;
    _titleView = [[titleScrollView alloc] initWithFrame:frame];
    [_titleView createItemsWithTitlesArray:titlesArray andTitleSize:size andTitleStyle:titleType andNormalColor:normalColor andSelectColor:selectColor];
    [self.view addSubview:_titleView];
   
    
    scrollView *sv = [[scrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_titleView.frame))];
    sv.tag = 1221;
    
    
    NSLog(@"%ld",self.childViewControllersNames.count);
    //数组赋值
    sv.childViewControllersNames = self.childViewControllersNames;
    sv.backgroundColor = [UIColor cyanColor];
    [sv createControllersScrollViewWithFrame:frame andControllersArray:controllersArray andButtonTag:0];

        
    
    [self.view addSubview:sv];
    
    //block方法 click
    _titleView.clickBlock = ^(NSInteger number){
        
        [sv changeLineLabelFrameWithPageNumber:number andTitleType:titleType];
    
    };
    
    
    sv.slideBlock = ^(NSInteger currentPage){
        
            [_titleView changeSelectedButtonWithCurrentPage:currentPage andTitlesType:titleType];
    };
    
    
    
}

- (void)titleChange:(NSNotification *)noti {
    
    NSArray *arr = [noti.userInfo objectForKey:@"keyword"];
    [_titleView setTTitlesArray:arr];
    
}

- (void)didReceiveMemoryWarning {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"titleChange" object:nil];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
