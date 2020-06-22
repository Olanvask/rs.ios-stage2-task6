//
//  FirstScreenViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "FirstScreenViewController.h"

@interface FirstScreenViewController() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSUserDomainMask, YES);
    NSString *myPath = [paths objectAtIndex:0];
    // if you save fies in a folder
    //myPath = [myPath stringByAppendingPathComponent:@"folder_name"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    // all files in the path
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:myPath error:nil];

    // filter image files
   
    for (int i = 0; i < directoryContents.count; i++) {
        NSString *imagePath = [myPath stringByAppendingPathComponent:[directoryContents objectAtIndex:i]];
        
        UIImage *tempImage = [UIImage imageWithContentsOfFile:imagePath];
        NSLog(@"%@", imagePath);
        // do something you want
    }
    
    /*
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]){
        cell.preview = [UIImage imageWithContentsOfFile:path1];
    }
    else {
        cell.preview = [UIImage imageNamed:@"Default-HTML5.PNG"];
    }*/
    
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    //self.view.backgroundColor = UIColor.redColor;
    
}
#pragma mark - UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    cell.textLabel.text = @"Hello";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}



@end
