//
//  InfoTableViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/26/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "InfoTableViewController.h"
#import "MediaAggregator.h"
#import "InfoTableViewCell.h"
#import "TableViewHeader.h"
#import "UIColor+task6.h"
#import "DetailViewController.h"
@interface InfoTableViewController()<UITableViewDelegate,UITableViewDataSource, MediaAggregatorDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MediaAggregator *mediaAggregator;
@property (nonatomic, strong) TableViewHeader *header;
@end

@implementation InfoTableViewController
//-------------------------------------------------------------------------------------------------
-(BOOL)prefersStatusBarHidden{
    return YES;
}
//-------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mediaAggregator = [MediaAggregator new];
    self.mediaAggregator.delegate = self;
    
    [self createTableView];
    
    [self makeConstraints];
    
}

//-------------------------------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
#pragma mark - Setup layout
//-------------------------------------------------------------------------------------------------
-(void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:InfoTableViewCell.class  forCellReuseIdentifier:@"TableViewCellID"];
    self.tableView.rowHeight = 90;
    self.tableView.backgroundColor = UIColor.task6White;
    
    [self.view addSubview:self.tableView];
    
    self.header = [TableViewHeader new];
    self.header.frame = CGRectMake(0, 0, 0, 80);
    [self.tableView setTableHeaderView:self.header];}

//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)){
        [NSLayoutConstraint activateConstraints:@[
            [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
        
    }else{
        [NSLayoutConstraint activateConstraints:@[
            [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//-------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mediaAggregator.collectionAssetResult.count;
}

//-------------------------------------------------------------------------------------------------
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID"];
    
    [cell setupCellFromAsset:[self.mediaAggregator.collectionAssetResult objectAtIndex:indexPath.row]  withSize:CGSizeMake(80, 80)];
    return cell;
}
#pragma mark - TableView delegate
//-------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *selectedCell = [[UIView alloc] init];
    selectedCell.backgroundColor = UIColor.task6HighlightedYellow;
    cell.selectedBackgroundView = selectedCell;
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    DetailViewController *detailViewController = [DetailViewController new];
    detailViewController.asset = [self.mediaAggregator.collectionAssetResult objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}
#pragma mark - Media aggregator delegate
//-------------------------------------------------------------------------------------------------
-(void)galleryDidChage:(PHFetchResultChangeDetails *)details{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
@end
