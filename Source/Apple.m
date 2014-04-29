//
//  Apple.m
//  Fruits
//
//  Created by Umang Methi on 4/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Apple.h"

@implementation Apple

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"apple";
}

@end
