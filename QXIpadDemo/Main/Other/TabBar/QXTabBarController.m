//
//  QXTabBarController.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXTabBarController.h"
#import "QXSplitRootViewController.h"
#import "QXMineVC.h"
#import "QXMessageVC.h"
#import "QXHomeVC.h"
@interface QXTabBarController ()

@end

@implementation QXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRootViewController];
    
//    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

-(void)setRootViewController{
   
//    NSArray * arrVCs = @[
//                         @{@"className":@"QXHomeVC",@"title":@"首页,@"image":@"home"},
//                         @{@"className":@"QXMessageVC",@"title":@"消息",@"image":@"message"},
//                         @{@"className":@"QXMineVC",@"title":@"我的",@"image":@"profile"},
//                         ];
//
//    NSData * data = [NSJSONSerialization dataWithJSONObject:arrVCs options:NSJSONWritingPrettyPrinted error:nil];
//    [data writeToFile:@"/Users/qianxiao/Desktop/QXIpadDemo/main.json" atomically:YES];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"json"];
    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray * arrVCs = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray * arrChildren = [NSMutableArray array];
    for(NSDictionary * dict in arrVCs){
        QXNavigationController * n = [self setViewContoller:dict];
        [arrChildren addObject:n];
    }
    self.viewControllers = arrChildren;
}

-(QXNavigationController *)setViewContoller:(NSDictionary *)dict{
    Class cls = NSClassFromString(dict[@"className"]);
    QXBaseViewController* qxVC = [[cls alloc] init];
    if ([qxVC isKindOfClass:[QXBaseViewController class]]) {
//        qxVC.navTitle = dict[@"title"];
    }
    qxVC.title = dict[@"title"];
    NSString * imageStr = dict[@"image"];
    qxVC.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_default",imageStr]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    qxVC.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_highted",imageStr]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    QXNavigationController * n = [[QXNavigationController alloc] initWithRootViewController:qxVC];
    return n;
}


+(instancetype)createTabBarController{
    QXTabBarController * tbc = [[QXTabBarController alloc] init];
    return tbc;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (!item) {
        return;
    }
    NSUInteger index = [tabBar.items indexOfObject:item];
    if(self.selectedIndex != index){
        [QXSplitRootViewController loadSplitControllerDetailDefaultVC];
    }
}

@end
