//
//  RMBookmarksViewController.m
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMBookmarksViewController.h"

@implementation RMBookmarksViewController {
    NSMutableArray *bookmarks;
}


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get a copy of bookmarks from shared instance
    bookmarks = [[[RMBookmarks sharedBookmarks] bookmarks] mutableCopy];
    
    self.tableView.rowHeight = 80.0;
    [self.tableView setEditing:YES animated:NO];
    [self.tableView reloadData];
}


#pragma mark - UITableView data source and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return bookmarks.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    RMMaster *master = [bookmarks objectAtIndex:indexPath.row];
    cell.textLabel.text = master.name;
    cell.detailTextLabel.text = master.mastery;
    cell.imageView.image = master.image;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



#pragma mark - IBActions


- (IBAction)doneButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
