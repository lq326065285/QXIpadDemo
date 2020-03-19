//
//  QXAddressBookVC.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/17.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXAddressBookVC.h"
#import "QXAddressBookSearchResultVC.h"
@interface QXAddressBookVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UISearchController * searchController;
@property (nonatomic,strong)QXAddressBookSearchResultVC * searchResultVC;
@end

@implementation QXAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    [self setupSearchVc];
    self.tableView.separatorColor = RGBA(220, 220, 220, 1);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kISiPad && self.searchController.isActive) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

-(void)setupSearchVc{
    WeakSelf
    QXAddressBookSearchResultVC * searchResultVC = [QXAddressBookSearchResultVC new];
    searchResultVC.vc = self;
    searchResultVC.tableScrollBlock = ^{
        [weakSelf.searchController.searchBar resignFirstResponder];
    };
    self.searchResultVC = searchResultVC;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    self.definesPresentationContext = YES;
    [self.searchResultVC setSearchController:_searchController searchBar:_searchController.searchBar];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.width, 50);
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"homeCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"张三_%ld",(long)indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"电话号码：1883333111%ld",(long)indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
