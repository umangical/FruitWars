//
//  Menu.m
//  Fruits
//
//  Created by Umang Methi on 4/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Menu.h"

@implementation Menu

- (void)one {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)two {
    CCScene *gameplayScene2 = [CCBReader loadAsScene:@"GameplayTwo"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene2];
}

 - (void)three {
    CCScene *gameplayScene3 = [CCBReader loadAsScene:@"GameplayThree"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene3];
}

- (void)four {
    CCScene *gameplayScene4 = [CCBReader loadAsScene:@"GameplayFour"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene4];
}

- (void)five {
    CCScene *gameplayScene5 = [CCBReader loadAsScene:@"GameplayFive"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene5];
}

- (void)six {
    CCScene *gameplayScene6 = [CCBReader loadAsScene:@"GameplaySix"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene6];
}

- (void)seven {
    CCScene *gameplayScene7 = [CCBReader loadAsScene:@"GameplaySeven"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene7];
}

- (void)eight {
    CCScene *gameplayScene8 = [CCBReader loadAsScene:@"GameplayEight"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene8];
}

@end
