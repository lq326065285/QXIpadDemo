//
//  QXNavigationController.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXNavigationController.h"
#import "AppDelegate.h"
@interface QXNavigationController ()

@end

@implementation QXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - publick

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    QXBaseViewController * vc = (QXBaseViewController *)viewController;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self setLeftItemWithVc:viewController];
        
//        [self splitDetailFirstPageItem:viewController];
    }
    [super pushViewController:viewController animated:animated];
}

//-(void)splitDetailFirstPageItem:(UIViewController *)viewController{
//    if (kISiPad) {
//        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        QXNavigationController * splitDetailNav = appDelegate.splitRootViewController.viewControllers.lastObject;
//        if ([splitDetailNav isKindOfClass:[QXNavigationController class]]) {
//            if ([self isKindOfClass:[splitDetailNav class]] && self.viewControllers.count == 0) {
//                viewController.navigationItem.leftBarButtonItem = appDelegate.splitRootViewController.displayModeButtonItem;
//                viewController.navigationItem.leftItemsSupplementBackButton = YES;
//            }
//        }
//    }
//}

-(void)setLeftItemWithVc:(UIViewController *)vc{
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_navBar_back_gray"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
     vc.navigationItem.leftBarButtonItem = leftItem;
     //解决滑动自定义leftBarButtonItem无法滑动发挥的问题
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
         self.interactivePopGestureRecognizer.delegate = nil;
     }
}

#pragma mark - response action

-(void)backAction:(UIBarButtonItem *)item{
    [self popViewControllerAnimated:YES];
}


@end
