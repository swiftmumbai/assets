//
//  RMAppDelegate.m
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMMasterViewController.h"
#import "RMMaster.h"

#define kBaseURLString     @"https://sites.google.com/site/soheilsstudio/tutorials/ioscrashlogtutorial/"
#define kDirectoryFile     @"RageMastersPictureDirectory_16MB.bmp"
#define kDatasourceFile    @"Masters.plist"
#define kMasterNameKey     @"Name"
#define kMasterMasteryKey  @"Mastery"
#define kMasterLocationKey @"Location"
#define kMasterImageKey    @"Image"

#define kIsFirstRunKey     @"first run key"


@implementation RMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL isFirstRun = ![[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstRunKey];
    if (isFirstRun) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstRunKey];
        
        // Download the Rage Masters photo directory
        NSURL *url = [NSURL URLWithString:[kBaseURLString stringByAppendingPathComponent:kDirectoryFile]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSURL *cacheDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSUserDirectory inDomains:NSCachesDirectory] lastObject];
        NSURL *filePath = [NSURL URLWithString:kDirectoryFile relativeToURL:cacheDirectory];
        [data writeToFile:[filePath absoluteString] atomically:YES];
    }
    
    // Load the data source from remote web site
    NSURL *datasourceURL = [NSURL URLWithString:[kBaseURLString stringByAppendingString:kDatasourceFile]];
    NSArray *arraysOfMasters = [NSArray arrayWithContentsOfURL:datasourceURL];
    NSMutableArray *masters = [NSMutableArray array];
    [arraysOfMasters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        NSString *name = [dic objectForKey:kMasterNameKey];
        NSString *mastery = [dic objectForKey:kMasterMasteryKey];
        NSString *location = [dic objectForKey:kMasterLocationKey];
        
        NSURL *imageURL = [NSURL URLWithString:[kBaseURLString stringByAppendingPathComponent:[dic objectForKey:kMasterImageKey]]];
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        RMMaster *aMaster = [[RMMaster alloc] initWithName:name
                                                   mastery:mastery
                                                  location:location
                                                     image:image];
        [masters addObject:aMaster];
    }];
    
    RMMasterViewController *controller = (RMMasterViewController *)[[((UINavigationController *)self.window.rootViewController) viewControllers] lastObject];
    controller.masters = masters;
    
    // Override point for customization after application launch.
    return YES;
}



@end
