//
//  QXBaseSearchResultVC.h
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/17.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXBaseViewController.h"

@protocol QXSearchResultDelegate <NSObject>
//需要用到searchController的相关方法在这重写
-(void)qx_willPresentSearchController:(UISearchController *)searchController;
-(void)qx_willDismissSearchController:(UISearchController *)searchController;
- (void)qx_searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

NS_ASSUME_NONNULL_BEGIN


@interface QXBaseSearchResultVC : QXBaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,QXSearchResultDelegate>
@property (nonatomic,copy) void(^selectSearchResultBlock)(id model);
@property (nonatomic,copy) void(^tableScrollBlock)(void);

@property (strong, nonatomic) UILabel *alertLab;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,weak) UIViewController * vc;
@property (weak, nonatomic) UISearchBar *searchBar;

-(void)setSearchController:(UISearchController *)searchControler searchBar:(UISearchBar *)searchBar;
//设置searchBar颜色为主题色
+(void)setColorWithSearchBar:(UISearchBar *)searchBar;

@end

NS_ASSUME_NONNULL_END
