//
//  WeiBoViewController.m
//  sinaweibo
//
//  Created by 王 金辨 on 12-9-24.
//  Copyright (c) 2012年 王 金辨. All rights reserved.
//
#import "WeiBoViewController.h"
#import "AppDelegate.h"
#import "PubUtil.h"
#import "WBTableViewCell.h"
#import "Constants.h"
#import <Weibo/WeiboSDK.h>
#import "WBModel.h"

@implementation WeiBoViewController {
    UILabel* tableHeaderView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView* bgImage =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgImage"]];

    [[self tableView] setBackgroundView:bgImage];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    UILabel* tableFooterView = [[UILabel alloc]
        initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    tableFooterView.text = @"加载更多";
    tableFooterView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = tableFooterView;
    tableHeaderView = [[UILabel alloc]
        initWithFrame:CGRectMake(0, -40, self.tableView.frame.size.width, 40)];
    tableHeaderView.text = @"下拉更新";
    tableHeaderView.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:tableHeaderView];
    PubUtil.refresh;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    WBTableViewCell* cell = (WBTableViewCell*)
        [self tableView:tableView
            cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [[PubUtil timeLine] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    WBModel* model = [[PubUtil timeLine] objectAtIndex:indexPath.row];
    WBTableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:model.identifier];
    [cell initDataByModel:model
                tableView:tableView];
    return cell;
}

- (IBAction)refresh:(id)sender
{
    PubUtil.refresh;
}
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.contentOffset.y > scrollView.frame.size.height) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < self.tableView.tableFooterView.frame.size.height) {
            PubUtil.loadMore;
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView
                  willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y <= 0 - tableHeaderView.frame.size.height) {
        PubUtil.loadNew;
    }
}
@end
