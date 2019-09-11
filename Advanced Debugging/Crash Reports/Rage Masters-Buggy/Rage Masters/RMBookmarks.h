//
//  RMBookmarks.h
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMMaster.h"

@interface RMBookmarks : NSObject

+ (RMBookmarks *)sharedBookmarks;

- (void)bookmarkMaster:(RMMaster *)master;

- (NSArray *)bookmarks;

- (void)unbookmarkMaster:(RMMaster *)master;

- (BOOL)canDoFunkyStuff;

@end
