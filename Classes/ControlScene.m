//
//  ControlScene.m
//  Control
//
//  Created by Johan Halin on 03.04.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import "ControlScene.h"
#import "ControlLayer.h"

@implementation ControlScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
	[background setPosition:ccp(160,240)];
	background.opacity = 0;
	[scene addChild:background z:0];
	[background runAction:[CCFadeIn actionWithDuration:2]];
	
	ControlLayer *control = [ControlLayer node];
	[scene addChild:control z:1];
	
	return scene;
}

@end
