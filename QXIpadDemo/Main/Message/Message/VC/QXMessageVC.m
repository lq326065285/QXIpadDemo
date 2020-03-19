//
//  QXMessageVC.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/13.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXMessageVC.h"
#import "QXAddressBookVC.h"
@interface QXMessageVC ()

@end

@implementation QXMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"通讯录" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickAddressBook)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kISiPad) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - button action

-(void)clickAddressBook{
    [self.navigationController pushViewController:QXAddressBookVC.new animated:YES];
}

@end
