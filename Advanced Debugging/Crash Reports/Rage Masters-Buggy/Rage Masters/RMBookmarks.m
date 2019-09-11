//
//  RMBookmarks.m
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMBookmarks.h"

@implementation RMBookmarks {
    NSMutableArray *_bookmarks;
    NSMutableArray *_funky;
}


static RMBookmarks *_sharedClass;


+ (RMBookmarks *)sharedBookmarks {
    
    if (!_sharedClass) {
        _sharedClass = [[RMBookmarks alloc] init];
    }
    return _sharedClass;
}


- (id)init {
    if (self = [super init]) {
        _bookmarks = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)dealloc {
    [_bookmarks release];
    [_funky release];
    [_sharedClass release];
    [super dealloc];
}



- (void)bookmarkMaster:(RMMaster *)master {
    
    NSObject *obj = [[NSObject alloc] init];
    [_funky addObject:obj];
    [obj release];
    
    [_bookmarks addObject:master];
}



- (NSArray *)bookmarks {
    return [[_bookmarks copy] autorelease];
}



- (void)unbookmarkMaster:(RMMaster *)master {
    [_bookmarks removeObject:master];
    master.isBookmarked = NO;
}


- (BOOL)canDoFunkyStuff {
    
    id object = [self freedObject];
    if (object)
        return YES;
    return NO;
}


- (id)freedObject {
    
    if (_bookmarks.count > 0) {
        id object = [_funky lastObject];
        [_funky removeLastObject];
        return object;
    }
    return nil;
}


@end
