//
//  RMDirectoryBrowser.m
//  Rage Masters
//
//  Created by Canopus on 10/31/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMLollipopLicker.h"

#define COUNT 20

@interface RMLollipopLicker ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *lickedTimeLabel;
@end


@implementation RMLollipopLicker {
    NSOperationQueue *queue;
    NSMutableArray *lollipops;
}

#pragma mark - Life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progressView.progress = 0.0;
    self.label.text = [NSString stringWithFormat:@"Tap on run and I'll lick a lollipop %d times!", COUNT];
    self.lickedTimeLabel.text = @"";
    
    lollipops = [[NSMutableArray alloc] init];
    queue = [[NSOperationQueue alloc] init];
}


- (void)lickLollipop {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Lollipop" withExtension:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:fileURL];
    NSString *lollipop = [dictionary objectForKey:@"Lollipop"];
    [lollipops addObject:lollipop];
}


#pragma mark - IBActions


- (IBAction)doneButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)runButtonPressed:(id)sender {
    
    [sender setEnabled:NO];
    [queue addOperationWithBlock:^{
        
        for (NSInteger i = 0 ; i <= COUNT ; i++) {
            [self lickLollipop];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self.label.text = [NSString stringWithFormat:@"Licked a strawberry lollipop %d time(s)!", i];
                self.lickedTimeLabel.text = [NSString stringWithFormat:@"Licked the same lollipop %d time(s)!", lollipops.count-1];
                self.progressView.progress = (float)(i/COUNT);
                
                if (i >= COUNT) {
                    self.label.text = [NSString stringWithFormat:@"Tap on run and I'll lick a lollipop %d times!", COUNT];
                    self.progressView.progress = 0.0;
                    [sender setEnabled:YES];
                }
            }];
        }
    }];
    
}

@end
