//
//  Watermelon.m
//  Fruits
//
//  Created by Umang Methi on 4/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Watermelon.h"

@implementation Watermelon

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"watermelon";
}

@end
