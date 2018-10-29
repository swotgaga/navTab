//
//  NavTabController.h
//  FMPlayer
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "titleScrollView.h"
#import "scrollView.h"

@interface NavTabController : UIViewController

@property (nonatomic,strong) NSArray *childViewControllersNames;

- (void)createItemsWithFrame:(CGRect)frame andControllersArray:(NSArray *)controllersArray andTitlesArray:(NSArray *)titlesArray andTitleSize:(CGFloat)size andTitleStyle:(titleType)titleType andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor;

@end
