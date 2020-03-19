
//
//  QXBaseSearchResultVC.m
//  QXIpadDemo
//
//  Created by ～～浅笑 on 2020/3/17.
//  Copyright © 2020 ～～浅笑. All rights reserved.
//

#import "QXBaseSearchResultVC.h"

#define SEARCHBAR_BACK_COLOR RGBA(230, 230, 230, 1)
#define SEARCHBAR_STATUS_BACK_COLOR RGBA(240, 240, 240, 1)
@interface QXBaseSearchResultVC ()<UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>

@end

@implementation QXBaseSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.view addSubview:self.alertLab];
    self.alertLab.hidden = YES;
    [self.alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
   
}


#pragma mark - private method

-(void)setSearchBarColor{
    //修改searchBar的输入框颜色
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >=     13.0) {
        self.searchBar.searchTextField.backgroundColor = SEARCHBAR_BACK_COLOR; //一般这个颜色都是全局的一个值
        self.searchBar.searchTextField.superview.clipsToBounds = YES;
        self.searchBar.clipsToBounds = YES;
    }else{
        UITextField *textField = [self.searchBar valueForKeyPath:@"_searchField"];
        textField.backgroundColor = SEARCHBAR_BACK_COLOR;
        textField.clearButtonMode = UITextFieldViewModeNever;
        [self.searchBar setValue:textField forKeyPath:@"_searchField"];
    }
}

#pragma mark - public method
-(void)setSearchController:(UISearchController *)searchControler searchBar:(UISearchBar *)searchBar{
    searchControler.delegate = self;
    searchBar.delegate = self;
    [searchBar setBackgroundImage:[UIImage new]]; //去掉searchBar黑线
    _searchBar = searchBar;
    
    //定制搜索框
    searchControler.searchBar.placeholder = @"搜索";
    searchControler.searchBar.backgroundColor = SEARCHBAR_STATUS_BACK_COLOR;
    searchControler.searchBar.tintColor = SEARCHBAR_STATUS_BACK_COLOR;
    searchControler.searchBar.barTintColor = SEARCHBAR_STATUS_BACK_COLOR;
    [searchControler.searchBar sizeToFit];
    
    //正在编辑的时候状态栏的颜色
    UIView * lightView = [UIView new];
    lightView.backgroundColor = SEARCHBAR_STATUS_BACK_COLOR;
    [searchControler.view insertSubview:lightView atIndex:0];
    [lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(STATUS_BAR_HEIGHT);
    }];
    
    
    [self setSearchBarColor];
}


//延迟一点点执行，让searBar右边的按钮出来了再去修改颜色，这样才会成功
+(void)setColorWithSearchBar:(UISearchBar *)searchBar{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for(UIView *view in searchBar.subviews)
        {
            for(UIView *subView in view.subviews){// iOS13新的获取方式
                if ([subView isKindOfClass:NSClassFromString(@"_UISearchBarSearchContainerView")]) {//_UISearchBarContainerView
                    for (UIView *mView in subView.subviews) {
                        if([mView isKindOfClass:NSClassFromString(@"UINavigationButton")])
                        {
                            [(UIButton *)mView setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
                        }
                    }
                }
                if([subView isKindOfClass:[UIButton class]]){//iOS13前获取的方式
                    [(UIButton *)subView setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
                }
            }
        }
    });
}

#pragma mark - UITableViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.tableScrollBlock) {
        self.tableScrollBlock();
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

#pragma mark - UISearchControllerDelegate

-(void)willPresentSearchController:(UISearchController *)searchController{
    [QXBaseSearchResultVC setColorWithSearchBar:self.searchBar];
    if([self respondsToSelector:@selector(qx_willPresentSearchController:)]){
        [self qx_willPresentSearchController:searchController];
    }
}

-(void)willDismissSearchController:(UISearchController *)searchController{
    if (kISiPad) {
        [self.vc.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    if([self respondsToSelector:@selector(qx_willDismissSearchController:)]){
        [self qx_willDismissSearchController:searchController];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
    self.alertLab.hidden = NO;
    if([self respondsToSelector:@selector(qx_searchBar:textDidChange:)]){
        [self qx_searchBar:searchBar textDidChange:searchText];
    }
}

#pragma mark - getter setter

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UILabel *)alertLab{
    if (!_alertLab) {
        _alertLab = [UILabel new];
        _alertLab.textColor = [UIColor colorWithHexString:@"C1C1C1"];
        _alertLab.text = @"没有相关内容";
    }
    return _alertLab;
}


@end
