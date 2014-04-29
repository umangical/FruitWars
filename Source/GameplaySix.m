//
//  GameplaySix.m
//  Fruits
//
//  Created by Umang Methi on 4/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameplaySix.h"

@implementation GameplaySix {
    
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_levelNode;
    CCNode *_contentNode;
    CCNode *_catapult;
    CCNode *_pullbackNode;
    CCPhysicsJoint *_catapultJoint;
    CCPhysicsJoint *_pullbackJoint;
    CCNode *_mouseJointNode;
    CCPhysicsJoint *_mouseJoint;
    
    CCNode *_currentFruit;
    CCPhysicsJoint *_fruitCatapultJoint;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level6"];
    [_levelNode addChild:level];
    
    // catapultArm and catapult shall not collide
    [_catapultArm.physicsBody setCollisionGroup:_catapult];
    [_catapult.physicsBody setCollisionGroup:_catapult];
    
    // create a joint to connect the catapult arm with the catapult
    _catapultJoint = [CCPhysicsJoint connectedPivotJointWithBodyA:_catapultArm.physicsBody bodyB:_catapult.physicsBody anchorA:_catapultArm.anchorPointInPoints];
    
    // nothing shall collide with our invisible nodes
    _pullbackNode.physicsBody.collisionMask = @[];
    // create a spring joint for bringing arm in upright position and snapping back when player shoots
    _pullbackJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_pullbackNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:60.f stiffness:500.f damping:40.f];
    
    _mouseJointNode.physicsBody.collisionMask = @[];
    _physicsNode.collisionDelegate = self;
    
}

// called on every touch in this scene
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    
    // start catapult dragging when a touch inside of the catapult arm occurs
    if (CGRectContainsPoint([_catapultArm boundingBox], touchLocation))
    {
        // move the mouseJointNode to the touch position
        _mouseJointNode.position = touchLocation;
        
        // setup a spring joint between the mouseJointNode and the catapultArm
        _mouseJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_mouseJointNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:0.f stiffness:3000.f damping:150.f];
        
        // create a penguin from the ccb-file
        _currentFruit = [CCBReader load:@"Cannonball"];
        // initially position it on the scoop. 34,138 is the position in the node space of the _catapultArm
        CGPoint fruitPosition = [_catapultArm convertToWorldSpace:ccp(34, 138)];
        // transform the world position to the node space to which the penguin will be added (_physicsNode)
        _currentFruit.position = [_physicsNode convertToNodeSpace:fruitPosition];
        // add it to the physics world
        [_physicsNode addChild:_currentFruit];
        // we don't want the penguin to rotate in the scoop
        _currentFruit.physicsBody.allowsRotation = FALSE;
        
        // create a joint to keep the penguin fixed to the scoop until the catapult is released
        _fruitCatapultJoint = [CCPhysicsJoint connectedPivotJointWithBodyA:_currentFruit.physicsBody bodyB:_catapultArm.physicsBody anchorA:_currentFruit.anchorPointInPoints];
    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // whenever touches move, update the position of the mouseJointNode to the touch position
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    _mouseJointNode.position = touchLocation;
}

- (void)releaseCatapult {
    if (_mouseJoint != nil)
    {
        // releases the joint and lets the catapult snap back
        [_mouseJoint invalidate];
        _mouseJoint = nil;
        
        // releases the joint and lets the penguin fly
        [_fruitCatapultJoint invalidate];
        _fruitCatapultJoint = nil;
        
        // after snapping rotation is fine
        _currentFruit.physicsBody.allowsRotation = TRUE;
        
        // follow the flying penguin
        CCActionFollow *follow = [CCActionFollow actionWithTarget:_currentFruit worldBoundary:self.boundingBox];
        [_contentNode runAction:follow];
    }
}

-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // when touches end, meaning the user releases their finger, release the catapult
    [self releaseCatapult];
}

-(void) touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    // when touches are cancelled, meaning the user drags their finger off the screen or onto something else, release the catapult
    [self releaseCatapult];
}

- (void)launchCannon {
    // loads the Penguin.ccb we have set up in Spritebuilder
    CCNode* cannon = [CCBReader load:@"Cannonball"];
    // position the penguin at the bowl of the catapult
    cannon.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    // add the penguin to the physicsNode of this scene (because it has physics enabled)
    [_physicsNode addChild:cannon];
    
    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [cannon.physicsBody applyForce:force];
    
    // ensure followed object is in visible are when starting
    self.position = ccp(0, 0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:cannon worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
}

- (void)retry {
    // reload this level
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"GameplaySix"]];
}

- (void)back {
    // reload menu
    CCScene *menuScene = [CCBReader loadAsScene:@"Menu"];
    [[CCDirector sharedDirector] replaceScene:menuScene];
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair orange:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    float energy = [pair totalKineticEnergy];
    
    // if energy is large enough, remove the seal
    if (energy > 5000.f)
    {
        [self orangeRemoved:nodeA];
    }
}

- (void)orangeRemoved:(CCNode *)orange {
    // load particle effect
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"OrangeExplosion"];
    // make the particle effect clean itself up, once it is completed
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = orange.position;
    // add the particle effect to the same node the seal is on
    [orange.parent addChild:explosion];
    
    // finally, remove the destroyed seal
    [orange removeFromParent];
}

@end
