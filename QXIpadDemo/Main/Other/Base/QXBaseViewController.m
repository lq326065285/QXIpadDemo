//
//  QXBaseViewController.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/12.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXBaseViewController.h"

@interface QXBaseViewController ()

@end

@implementation QXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES; 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
