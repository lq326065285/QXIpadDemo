//
//  AppDelegate.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    self.tabBarController = [QXTabBarController createTabBarController];
    if (kISiPad) {
        [self setupIpadRootView];
    }else{
        self.window.rootViewController = self.tabBarController;
    }
    
    return YES;
}

-(void)setupIpadRootView{
    self.splitRootViewController = [QXSplitRootViewController createSplitVc];
    [QXSplitRootViewController loadRightDefaultVCWithIsCreate:YES];
    self.window.rootViewController = self.splitRootViewController;
    [QXSplitRootViewController updateSplitViewContollers];
}


@end
