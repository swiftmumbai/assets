//
//  RMMaster.m
//  Rage Masters
//
//  Created by Canopus on 10/8/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMMaster.h"

@implementation RMMaster


- (id)initWithName:(NSString *)name mastery:(NSString *)mastery location:(NSString *)location image:(UIImage *)image {
    
    if (self = [super init]) {
        
        self.name = name;
        self.mastery = mastery;
        self.location = location;
        self.image = image;
    }
    
    return self;
}

@end
