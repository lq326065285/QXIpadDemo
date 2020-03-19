//
//  QXHomeVC.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/13.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXHomeVC.h"
#import "QXHomeDetailVC.h"
@interface QXHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation QXHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"homeCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"行---%ld，列---%ld",(long)indexPath.section,(long)indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld::%ld",(long)indexPath.section,(long)indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXHomeDetailVC * detailVC = [QXHomeDetailVC new];
    detailVC.page = 1;
    detailVC.content = [NSString stringWithFormat:@"这是第%ld列，第%ld行",(long)indexPath.section,(long)indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
