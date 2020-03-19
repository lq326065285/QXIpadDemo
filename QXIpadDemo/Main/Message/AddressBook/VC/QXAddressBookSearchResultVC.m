//
//  BSAddressBookSearchResultVC.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/17.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXAddressBookSearchResultVC.h"

@interface QXAddressBookSearchResultVC ()

@end

@implementation QXAddressBookSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - QXSearchResultDelegate

-(void)qx_willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"%s",__func__);
}


-(void)qx_willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"%s",__func__);
}

- (void)qx_searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s",__func__);
}

#pragma mark - 

@end
