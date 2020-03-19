//
//  QXSplitRootViewController.h
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kSplitScale             0.4

NS_ASSUME_NONNULL_BEGIN

@interface QXSplitRootViewController : UISplitViewController
+(instancetype)createSplitVc;

//加载splitController中detail的第一个vc
+(void)loadSplitControlerFirstDetailViewController:(UIViewController *)vc;

/// 显示detailVC默认vc
+(void)loadSplitControllerDetailDefaultVC;

/// 是否显示右边详情vc
+(BOOL)isShowSplitDetailVC;

///横竖屏，多任务的情况下调整splitView的布局
+(void)updateSplitViewContollers;
@end

NS_ASSUME_NONNULL_END
