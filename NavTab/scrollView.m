//
//  scrollView.m
//  FMPlayer
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#define SCROLL_HEIGHT 667
#define SCROLL_WIDTH  375

#import "scrollView.h"
#import "UIViewController+SharedViewController.h"


@interface scrollView  ()

@property (nonatomic,strong) titleScrollView *titleView;

@end

@implementation scrollView

//- (instancetype)init {
//    self = [super init];
//    if (!self) {
//        
//    }
//    return self;
//}

- (void)createControllersScrollViewWithFrame:(CGRect)frame andControllersArray:(NSArray *)controllersArray andButtonTag:(NSInteger)tag {
    self.userInteractionEnabled = YES;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCROLL_WIDTH*controllersArray.count, 0);
    NSLog(@"new%ld",controllersArray.count);
    _scrollView.alwaysBounceHorizontal = YES;
    
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    [self addSubview:_scrollView];
    
    
    NSString *firstVCName = [self.childViewControllersNames firstObject];
//    NSLog(@"%@",firstVCName);
    
    UIViewController *firstVC= [NSClassFromString(firstVCName) shareViewController];
    
    [_scrollView addSubview:firstVC.view];
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (scrollView.contentOffset.x+SCROLL_WIDTH/2)/SCROLL_WIDTH;
//    NSLog(@"hahahahhaha%ld",currentPage);
    
    
    static NSInteger lastPage = 0;
    if (lastPage != currentPage) {
        self.slideBlock(currentPage);
        lastPage = currentPage;
    }
    
    
    UIViewController *vc = [NSClassFromString(self.childViewControllersNames[currentPage]) shareViewController];
    
    if (![self.subviews containsObject:vc.view]) {
        
        vc.view.frame = CGRectMake(SCROLL_WIDTH*currentPage, 0, SCROLL_WIDTH, SCROLL_HEIGHT);
        [_scrollView addSubview:vc.view];
    }
}

- (void)changeLineLabelFrameWithPageNumber:(NSInteger)number andTitleType:(titleType)titleType {
    
    __weak typeof(self)weakSelf = self;
    UIViewController *vc = [NSClassFromString(weakSelf.childViewControllersNames[number]) shareViewController];
    
    if (![self.subviews containsObject:vc.view]) {
        
        vc.view.frame = CGRectMake(SCROLL_WIDTH*number, 0, SCROLL_WIDTH, SCROLL_HEIGHT);
        [_scrollView addSubview:vc.view];
    }
    
    _scrollView.contentOffset = CGPointMake(SCROLL_WIDTH*number,0);
   
//    _scrollView.contentOffset = CGPointMake(SCROLL_WIDTH*number, 0);
    
    if (number) {
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"ccc%ld",number+1] object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ccc" object:nil];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
