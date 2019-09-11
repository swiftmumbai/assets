//
//  RMDetailViewController.m
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMDetailViewController.h"

#define kBookmarkImageON  [UIImage imageNamed:@"bookmark_on.png"];


@interface RMDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bookmarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *masterImageView;
@property (weak, nonatomic)IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *masteryLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;
@end


@implementation RMDetailViewController


#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.nameLabel.text = self.master.name;
    self.masteryLabel.text = self.master.mastery;
    self.locationLabel.text = self.master.location;
    self.masterImageView.image = self.master.image;
    [self updateBookmarkImage];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateBookmarkImage {
    
    if (self.master.isBookmarked) {
        
        self.bookmarkImageView.image = kBookmarkImageON;
        [self.bookmarkButton setTitle:NSLocalizedString(@"Remove as my favorite!", @"Remove as my favorite!") forState:UIControlStateNormal];
    }
    else {
        
        self.bookmarkImageView.image = nil;
        [self.bookmarkButton setTitle:NSLocalizedString(@"Bookmark as my favorite!", @"Bookmark as my favorite!") forState:UIControlStateNormal];
    }
}


#pragma mark - IBActions

- (IBAction)bookmarkButtonPressed  {
    
    self.master.isBookmarked = !self.master.isBookmarked;
    
    // Update shared bookmarks
    if (self.master.isBookmarked)
        [[RMBookmarks sharedBookmarks] bookmarkMaster:self.master];
    else
        [[RMBookmarks sharedBookmarks] unbookmarkMaster:self.master];
    
    // Update UI
    [self updateBookmarkImage];
}


- (IBAction)doFunkyStuffTapped:(id)sender {
    
    BOOL canDoFunkySuff = [[RMBookmarks sharedBookmarks] canDoFunkyStuff];
    if (canDoFunkySuff) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Funky" message:@"Liar Liar Pants On Fire" delegate:nil cancelButtonTitle:@"Ew!" otherButtonTitles:@"Bingo!", nil];
        [alert show];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uhm!" message:@"Bookmark some to get funky!" delegate:nil cancelButtonTitle:@"Get out!" otherButtonTitles:@"Not me!", nil];
        [alert show];
    }
}
@end
