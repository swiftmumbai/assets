//
//  RMMaster.h
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMMaster : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *mastery;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) UIImage *image;
@property (nonatomic) BOOL isBookmarked;

- (id)initWithName:(NSString *)name mastery:(NSString *)mastery location:(NSString *)location image:(UIImage *)image;

@end
