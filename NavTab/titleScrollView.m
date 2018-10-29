//
//  titleScrollView.m
//  FMPlayer
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//
#define VIEW_SIZE self.bounds.size

#import "titleScrollView.h"
#import "scrollView.h"

@interface titleScrollView ()

@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UIScrollView *topScrollView;


@end

@interface titleScrollView ()

@property (nonatomic, strong) scrollView *sc;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation titleScrollView {
    NSInteger countt;
}
//重写构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.alwaysBounceHorizontal = YES;
        _topScrollView.alwaysBounceVertical = NO;
      
        [self addSubview:_topScrollView];        
    }
    return self;
}

- (void)createItemsWithTitlesArray:(NSArray *)titlesArray andTitleSize:(CGFloat)titleSize andTitleStyle:(titleType)titleType andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor {

//    _topScrollView.bounces = NO;
//    _topScrollView.contentSize = CGSizeMake(VIEW_SIZE.width, 0);
    
    self.titlesArray = titlesArray;
    int count = (int)titlesArray.count;
    countt = count;
    CGFloat contentSize = 0;
    //button的宽和高
    int w = self.bounds.size.width/count;
    int h = self.bounds.size.height;
    //for循环根据数组创建 button
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+10;
        button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
        //根据type区分button的大小
        
        if (titleType == titleTypeEquallySize) {
            
            button.frame = CGRectMake(0, 0, w, h);
            button.center = CGPointMake(w/2+i*w, h/2);
            
            
        }else{
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
            CGSize size = CGSizeMake(MAXFLOAT, button.frame.size.height);
            CGFloat titleWidth = [titlesArray[i] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            
            button.frame = CGRectMake(0, 0, titleWidth, h);

            if (titleType == titleTypeAutoSize) {
                contentSize += titleWidth;
                button.center = CGPointMake(contentSize-titleWidth/2 , h/2);
            }else{
                button.center = CGPointMake(w/2+i*w, h/2);
            }

            if (titleType == titleTypeAutoSize) {
                [button addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            }

        }
        
        if (titleType == titleTypeAutoSize) {
            _topScrollView.bounces = YES;
            _topScrollView.contentSize = CGSizeMake(contentSize, 0);
        }else{
            _topScrollView.bounces = NO;
            _topScrollView.contentSize = CGSizeMake(w, 0);
        }
        
        //button标题和颜色
        [button setTitle:titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:normalColor forState:UIControlStateNormal];
        [button setTitleColor:selectColor forState:UIControlStateSelected];
 
        [_topScrollView addSubview:button];
        //默认选中第一个button
        if (button.tag == 10) {
            button.selected = YES;
        }
        
    }
    
    
    [self createLineLabelWithColor:selectColor andTitleStyle:titleType];
    
}

//button点击方法
- (void)onClick:(UIButton *)button {
   
    //    NSLog(@"tag:%ld",button.tag-10);
    self.clickBlock(button.tag-10);

    
    for(int i = 0; i < self.titlesArray.count; i++)
    {
        UIButton *button = (id)[self viewWithTag:i+10];
        button.selected = NO;
        
    }
    button.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
//        if (_lineLabel.center.x >= VIEW_SIZE.width/2 && _lineLabel.center.x <= _topScrollView.contentSize.width-_lineLabel.frame.size.width) {
//            [_topScrollView setContentOffset:CGPointMake(_lineLabel.center.x-VIEW_SIZE.width/2, 0) animated:YES];
//        }else if(_lineLabel.center.x < VIEW_SIZE.width/2){
//            [_topScrollView setContentOffset:CGPointZero animated:YES];
//        }else if(_lineLabel.center.x > _topScrollView.contentSize.width-VIEW_SIZE.width){
//            [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentSize.width-VIEW_SIZE.width, 0)];
//        }

        
    }];
    
//    协议方法
//    if (self.delegate && [self.delegate respondsToSelector:@selector(getItem:andTag:)]) {
//        [self.delegate getItem:button andTag:button.tag];
//    }
    
    
}

- (void)onClick1:(UIButton *)button {
    
    //    NSLog(@"tag:%ld",button.tag-10);
    self.clickBlock(button.tag-10);

    
        for(int i = 0; i < self.titlesArray.count; i++)
        {
            UIButton *button = (id)[self viewWithTag:i+10];
            button.selected = NO;
            
        }
        button.selected = YES;
    
    float width = button.frame.size.width;
    CGRect lineRect = self.lineLabel.frame;
    lineRect.size.width = width/1.3;
    self.lineLabel.frame = lineRect;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
        if (_lineLabel.center.x >= VIEW_SIZE.width/2 && _lineLabel.center.x <= _topScrollView.contentSize.width-_lineLabel.frame.size.width) {
            [_topScrollView setContentOffset:CGPointMake(_lineLabel.center.x-VIEW_SIZE.width/2, 0) animated:YES];
        }else if(_lineLabel.center.x < VIEW_SIZE.width/2){
            [_topScrollView setContentOffset:CGPointZero animated:YES];
        }else if(_lineLabel.center.x > _topScrollView.contentSize.width-VIEW_SIZE.width){
            [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentSize.width-VIEW_SIZE.width, 0)];
        }

        
    }];
    //    协议方法
//    if (self.delegate && [self.delegate respondsToSelector:@selector(getItem:andTag:)]) {
//        [self.delegate getItem:button andTag:button.tag];
//    }
    
}

- (void)changeSelectedButtonWithCurrentPage:(NSInteger)currentPage andTitlesType:(titleType)titleType {
    
    for(int i = 0; i < self.titlesArray.count; i++)
    {
        UIButton *button = (id)[self viewWithTag:i+10];
        button.selected = NO;
        
    }
    UIButton *button = (id)[self viewWithTag:currentPage+10];
    button.selected = YES;
    
    
    if (titleType == titleTypeDefaultSize) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            float width = button.frame.size.width;
            CGRect lineRect = self.lineLabel.frame;
//            lineRect.size.width = width/1.3;
            lineRect.size.width = 75;
            self.lineLabel.frame = lineRect;
            
            self.lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
        }];
        
    }
    
    if (titleType == titleTypeEquallySize) {
        [UIView animateWithDuration:0.3 animations:^{
            self.lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
        }];
    }

    if (titleType == titleTypeAutoSize) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
            if (_lineLabel.center.x >= VIEW_SIZE.width/2 && _lineLabel.center.x <= _topScrollView.contentSize.width-_lineLabel.frame.size.width) {
                [_topScrollView setContentOffset:CGPointMake(_lineLabel.center.x-VIEW_SIZE.width/2, 0) animated:YES];
            }else if(_lineLabel.center.x < VIEW_SIZE.width/2){
                [_topScrollView setContentOffset:CGPointZero animated:YES];
            }else if(_lineLabel.center.x > _topScrollView.contentSize.width-VIEW_SIZE.width){
                [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentSize.width-VIEW_SIZE.width, 0)];
            }
            
        }];
        
    }
//        else{
//
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            _lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
//            
//            
//        }];
        
        
//        CABasicAnimation *anim=[CABasicAnimation animation];
//        anim.keyPath=@"transform.translation.x";
//        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(button.frame.size.width, self.bounds.size.height-1)];
//        anim.duration=2.0;
//        anim.removedOnCompletion=NO;
//        anim.fillMode=kCAFillModeForwards;
//        
//        [_lineLabel.layer addAnimation:anim forKey:nil];
//    }
    
            if (currentPage) {
                [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"ccc%ld",currentPage] object:nil];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ccc" object:nil];
            }
   

}



#pragma mark -- 创建下划线lineLabel
- (void)createLineLabelWithColor:(UIColor *)selectColor andTitleStyle:(titleType)titleType {
    
    UIButton *button = (id)[self viewWithTag:10];
    
    if (titleType == titleTypeEquallySize) {
        
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.bounds.origin.x, self.bounds.size.height-2, button.frame.size.width, 2)];
        
    }else{
//
//        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.bounds.origin.x, self.bounds.size.height-2, button.frame.size.width/1.3, 2)];
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.bounds.origin.x, self.bounds.size.height-2, 75, 2)];
        
    }
    
    _lineLabel.center = CGPointMake(button.center.x, self.bounds.size.height-1);
    
    _lineLabel.backgroundColor = selectColor;
    [_topScrollView addSubview:_lineLabel];
    
    
}

- (void)setTTitlesArray:(NSArray *)tTitlesArray {
    
    NSString *a = tTitlesArray[0];
    UIButton *button = (id)[self viewWithTag:a.integerValue+10];
    [button setTitle:tTitlesArray[1] forState:UIControlStateNormal];
    
    CGRect frame = button.frame;
    frame.origin.x = self.bounds.size.width/countt;
    frame.size.width = self.bounds.size.width/countt;
    button.frame = frame;
    
}

#pragma mark -- 懒加载
- (NSArray *)titlesArray {
    
    if (_titlesArray == nil) {
        _titlesArray = [NSArray array];
    }
    
    return _titlesArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
