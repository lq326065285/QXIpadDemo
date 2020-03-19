
//
//  UINavigationController+category.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2019 bingosoft. All rights reserved.
//

#import "UINavigationController+category.h"
#import "QXSplitRootViewController.h"
@implementation UINavigationController (category)

void nav_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nav_swizzleMethod([self class], @selector(pushViewController:animated:), @selector(swizzle_pushViewController:animated:));
    });
}

-(void)swizzle_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController * vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (self.viewControllers.count == 1 && [vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController * splitVC = (UISplitViewController *)vc;
        UITabBarController * tbc = splitVC.viewControllers.firstObject;
        UINavigationController * nav = splitVC.viewControllers.lastObject;
        if (nav != self && [tbc.viewControllers containsObject:self] && splitVC.viewControllers.count > 1 && [QXSplitRootViewController isShowSplitDetailVC]) {  //判断下如果当前导航和splitViewController的lastObject导航是同一个，说明这是二级界面的跳转，就直接让他走之前的push方法，如果不是，说明是firstVC的跳转，直接改lastObject的rootVC
            [QXSplitRootViewController loadSplitControlerFirstDetailViewController:viewController];
        }else{
            [self swizzle_pushViewController:viewController animated:animated];
        }
    }else{
        [self swizzle_pushViewController:viewController animated:animated];
    }
}

@end
