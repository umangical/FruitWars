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

/*
 - (void)playThree {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)playFour {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)playFive {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)playSix {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)playSeven {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)playEight {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
 
*/

@end
