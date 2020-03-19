//
//  AppDelegate.h
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QXSplitRootViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) QXTabBarController *tabBarController;
@property (strong,nonatomic)  QXSplitRootViewController *splitRootViewController;      //声明分割控制器
@end

