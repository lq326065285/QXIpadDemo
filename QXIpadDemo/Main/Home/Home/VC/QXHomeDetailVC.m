//
//  QXHomeDetailVC.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/13.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXHomeDetailVC.h"

@interface QXHomeDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation QXHomeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"第%ld页",self.page];
    self.contentLab.text = self.content;
}

- (IBAction)clickGotoNextVC:(id)sender {
    QXHomeDetailVC * detailVC = [QXHomeDetailVC new];
    detailVC.content = self.content;
    detailVC.page = self.page + 1;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
