//
//  RMMasterViewController.m
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMMasterViewController.h"


@interface RMMasterViewController ()
@property (nonatomic, strong) NSMutableArray *rageRequests;
@end


@implementation RMMasterViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.rowHeight = 80.0;
    self.rageRequests = [[NSMutableArray alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.masters.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Update cell content
    RMMaster *master = [self.masters objectAtIndex:indexPath.row];
    cell.textLabel.text = master.name;
    cell.detailTextLabel.text = master.mastery;
    cell.imageView.image = master.image;
        
    // Create a bookmark button and set it as the accessory view of the cell
    UIButton *bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton setFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
    [bookmarkButton setImage:[UIImage imageNamed:@"bookmark_on.png"] forState:UIControlStateSelected];
    [bookmarkButton setImage:[UIImage imageNamed:@"bookmark_off.png"] forState:UIControlStateNormal];
    [bookmarkButton addTarget:self action:@selector(bookmarkButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [bookmarkButton setTag:indexPath.row];
    [bookmarkButton setSelected:master.isBookmarked];
    cell.accessoryView = bookmarkButton;
    
    return cell;
}


#pragma mark - segues management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RMMaster *master = [self.masters objectAtIndex:indexPath.row];
        [[segue destinationViewController] setMaster:master];
    }
}


#pragma mark - IBActions


- (IBAction)bookmarkButtonPressed:(id)sender {
    
    // Get the index of Rage Master from button tag
    UIButton *bookmarkButton = (UIButton *)sender;
    NSInteger index = bookmarkButton.tag;
    
    // Bookmark it
    RMMaster *master = [self.masters objectAtIndex:index];
    master.isBookmarked = !master.isBookmarked;
    
    // and register it in shared bookmarks
    [[RMBookmarks sharedBookmarks] bookmarkMaster:master];
    
    // Set bookmarkButton to keep selected state
    [bookmarkButton setSelected:!bookmarkButton.isSelected];
}


@end
