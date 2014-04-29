//
//  Strawberry.m
//  Fruits
//
//  Created by Umang Methi on 4/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Strawberry.h"

@implementation Strawberry

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"strawberry";
}

@end
