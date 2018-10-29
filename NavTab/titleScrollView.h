//
//  titleScrollView.h
//  FMPlayer
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>
//typedef NS_ENUM(NSUInteger,titleType)
//{
//    /**默认效果，title不可滑动*/
//    titleTypeDefaultSize = 1 << 0,
//    /**根据button数量均分大小，title不可滑动*/
//    titleTypeEquallySize = 1 << 1,
//    /**跟随button自适应大小，title可以滑动*/
//    titleTypeAutoSize    = 1 << 2,
//};

//@protocol titleScrollDelegate <NSObject>
//
//- (void)getItem:(UIButton *)button andTag:(NSInteger)tag;
//
//@end

@interface titleScrollView : UIView

typedef NS_ENUM(NSUInteger,titleType)
{
    /**默认效果，title不可滑动*/
    titleTypeDefaultSize = 1 << 0,
    /**根据button数量均分大小，title不可滑动*/
    titleTypeEquallySize = 1 << 1,
    /**跟随button自适应大小，title可以滑动*/
    titleTypeAutoSize    = 1 << 2,
};

//@property (nonatomic,weak) id<titleScrollDelegate> delegate;

@property (nonatomic,strong) NSArray *tTitlesArray;
@property (nonatomic, copy) void (^clickBlock)(NSInteger number);

- (void)createItemsWithTitlesArray:(NSArray *)titlesArray andTitleSize:(CGFloat)size andTitleStyle:(titleType)titleType andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor;

- (void)changeSelectedButtonWithCurrentPage:(NSInteger)currentPage andTitlesType:(titleType)titleType;

@end
