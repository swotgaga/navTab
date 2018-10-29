//
//  scrollView.h
//  FMPlayer
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "titleScrollView.h"
@interface scrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *childViewControllersNames;

@property (nonatomic, copy) void (^slideBlock)(NSInteger number);

- (void)createControllersScrollViewWithFrame:(CGRect)frame andControllersArray:(NSArray *)controllersArray andButtonTag:(NSInteger)tag;

- (void)changeLineLabelFrameWithPageNumber:(NSInteger)number andTitleType:(titleType)titleType;

@end
