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
	[background setScale:480];
	[background setPosition:ccp(160,240)];
	[scene addChild:background z:0];
	
	ControlLayer *control = [ControlLayer node];
	[scene addChild:control z:1];
	
	return scene;
}

@end
