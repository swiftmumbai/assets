//
//  RMRageRequest.m
//  Rage Masters
//
//  Created by Canopus on 10/13/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "RMRageRequest.h"

@interface RMRageRequest ()
@property (nonatomic, copy) UIImage *image;
@end


@implementation RMRageRequest


- (id)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}

@end
