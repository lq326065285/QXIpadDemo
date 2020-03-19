//
//  BSSplitRootViewController.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXSplitRootViewController.h"
#import "AppDelegate.h"
#import "QXSplitRightDefaultVC.h"
CGFloat _windowWidth;
@interface QXSplitRootViewController ()
{
    
}
@end

@implementation QXSplitRootViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - publick method

+(instancetype)createSplitVc{
    //创建分割控制器
   QXSplitRootViewController * splitRootViewController = [[QXSplitRootViewController alloc]init];
//    [QXSplitRootViewController loadSplitControllerDetailDefaultVC];
    splitRootViewController.maximumPrimaryColumnWidth = [UIScreen mainScreen].bounds.size.width;
    //设置分割控制器分割模式
    splitRootViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    splitRootViewController.preferredPrimaryColumnWidthFraction = kSplitScale;
    return splitRootViewController;
}

+(void)loadSplitControlerFirstDetailViewController:(UIViewController *)vc{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    QXNavigationController *detailNav = [[QXNavigationController alloc] initWithRootViewController:vc];
    appDelegate.splitRootViewController.viewControllers = @[appDelegate.tabBarController,detailNav];
    vc.navigationItem.leftBarButtonItem = appDelegate.splitRootViewController.displayModeButtonItem;
    vc.navigationItem.leftItemsSupplementBackButton = YES;
}


+(void)loadSplitControllerDetailDefaultVC{
    [self createDetailVCWithIsDefault:YES];
}

+(BOOL)isShowSplitDetailVC{
    if (ScreenWidth > ScreenHeight) {//宽>高 横屏
        CGFloat tWindowWidth = _windowWidth;
        if (tWindowWidth == 0) {
            tWindowWidth = [UIApplication sharedApplication].keyWindow.bounds.size.width;
        }
        if (tWindowWidth > ScreenWidth / 2.0) { //多任务大于半
            return YES;
        }else{
            return NO;
        }
    }else{ //竖屏直接排除
        return NO;
    }
}

+(void)updateSplitViewContollers{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(![appDelegate.splitRootViewController isKindOfClass:[UISplitViewController class]]){//不是splitViewController的情况直接过
        return;
    }
    if ([self isShowSplitDetailVC]) {//需要显示详情
        [self showSplitMasterAndDetail];
    }else{//不需要显示详情
        [self showOnlySplitMaster];
    }
}

#pragma mark - private method

+(UINavigationController *)createDetailVCWithIsDefault:(BOOL)isDefault{
    QXSplitRightDefaultVC * defaultVC = [QXSplitRightDefaultVC new];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    QXNavigationController *detailNav = [[QXNavigationController alloc] initWithRootViewController:defaultVC];
    if (!isDefault || [appDelegate.splitRootViewController.viewControllers.lastObject isKindOfClass:[UINavigationController class]]) {
        appDelegate.splitRootViewController.viewControllers = @[appDelegate.tabBarController,detailNav];
        defaultVC.navigationItem.leftBarButtonItem = appDelegate.splitRootViewController.displayModeButtonItem;
        defaultVC.navigationItem.leftItemsSupplementBackButton = YES;
    }
    return detailNav;
}

//竖屏
+(void)showOnlySplitMaster{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray * splitViewControllers = appDelegate.splitRootViewController.viewControllers;
    if (splitViewControllers.count != 1 || appDelegate.splitRootViewController.preferredPrimaryColumnWidthFraction != 1) {
        appDelegate.splitRootViewController.preferredPrimaryColumnWidthFraction = 1;
        UINavigationController * detailNav = appDelegate.splitRootViewController.viewControllers.lastObject;
        if ([detailNav isKindOfClass:[UINavigationController class]]) {//如果是tabBar直接过掉
            QXBaseViewController * firstVc = detailNav.viewControllers.firstObject;
            if (detailNav.viewControllers.count > 1 || (detailNav.viewControllers.count == 1 && ![firstVc isKindOfClass:[QXSplitRightDefaultVC class]])) {
                //tabBar上面选中的nav
                NSMutableArray * detailNavViewControllers = [NSMutableArray arrayWithArray:detailNav.viewControllers];
                
                firstVc = detailNavViewControllers.firstObject;
                if ([firstVc isKindOfClass:[QXSplitRightDefaultVC class]]) {//如果第一个是默认页面，去掉
                    [detailNavViewControllers removeObjectAtIndex:0];
                }
                
                [self setSplitDetailNavBarItem:firstVc];
                
                //拿到tabBar上被选中的nav
                UITabBarController * tbc = appDelegate.splitRootViewController.viewControllers.firstObject;
                UINavigationController * selectNav = tbc.selectedViewController;

                //设置堆栈
                [detailNavViewControllers insertObject:selectNav.viewControllers.firstObject atIndex:0];
                selectNav.viewControllers = detailNavViewControllers;
            }
        }
    }
    //曹丹的iOS13,preferredPrimaryColumnWidthFraction = 1;自动选择splitView中detailVC，为了适配新旧版本，将detailVC和masterVc设置成一样的就好了
    appDelegate.splitRootViewController.viewControllers = @[appDelegate.tabBarController,appDelegate.tabBarController];
}

//设置第一个页面顶部可以全屏的按钮
+(void)setSplitDetailNavBarItem:(QXBaseViewController *)firstVc {
    //如果横屏点击，detail进入第一个页面，再竖屏会多一个返回按钮，这里做个特殊处理
    //隐藏系统返回按钮
    [firstVc.navigationItem setHidesBackButton:YES];
    [(QXNavigationController *)firstVc.navigationController setLeftItemWithVc:firstVc];
}

//横屏
+(void)showSplitMasterAndDetail{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray * splitViewControllers = appDelegate.splitRootViewController.viewControllers;
    if (splitViewControllers.count != 2 || appDelegate.splitRootViewController.preferredPrimaryColumnWidthFraction == 1) {//如果最开始的viewControllers就为2说明之前就是这种模式，不用管
        appDelegate.splitRootViewController.preferredPrimaryColumnWidthFraction = kSplitScale;
        UINavigationController * detailNav = [self createDetailVCWithIsDefault:NO];
        UITabBarController * tbc = appDelegate.splitRootViewController.viewControllers.firstObject;
        UINavigationController * selectNav = tbc.selectedViewController;
        if (selectNav.viewControllers.count > 1) {
            //tabBar上面选中的nav
            NSMutableArray * selectNavViewControllers = [NSMutableArray arrayWithArray:selectNav.viewControllers];
            //选中nav最顶层的控制器
            //将顶层控制器放在tabBar上面选中的nav
            UIViewController * firstVc = selectNav.viewControllers.firstObject;
            selectNav.viewControllers = @[firstVc];
            //去掉顶层控制器
            [selectNavViewControllers removeObjectAtIndex:0];
            detailNav.viewControllers = selectNavViewControllers;
            if (selectNavViewControllers.count >= 1) {
                UINavigationController * firstNav = selectNavViewControllers.firstObject;
                firstNav.navigationController.navigationBar.hidden = NO;
                
                //隐藏系统返回按钮
                firstNav.navigationItem.leftBarButtonItem = appDelegate.splitRootViewController.displayModeButtonItem;
                firstNav.navigationItem.leftItemsSupplementBackButton = YES;
                
                [self resetLeftBarButtonItemWithArr:selectNavViewControllers];
            }
        }else{
            [self loadSplitControllerDetailDefaultVC];
        }
    }
}

//竖屏进入的堆栈，横屏进入，得重设一下，不然有时候返回按钮会失效 ，因为重设是新创建出来的navigation，不再是之前的那个了，所以返回上一层的事件无法响应 => 0_0
+(void)resetLeftBarButtonItemWithArr:(NSArray *)arr{
    for (int i = 1; i < arr.count; i++) {
        UIViewController * vc = arr[i];
        [(QXNavigationController *)vc.navigationController setLeftItemWithVc:vc];
    }
}

#pragma mark - UIContentContainer

// 屏幕size改变：方向变化、分屏
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    NSLog(@"viewWillTransitionToSize: size %@", NSStringFromCGSize(size));
    _windowWidth = size.width;
    [QXSplitRootViewController updateSplitViewContollers];
}

@end
