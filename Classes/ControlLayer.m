//
//  ControlLayer.m
//  Control
//
//  Created by Johan Halin on 03.04.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import "ControlLayer.h"

@implementation ControlLayer

const float kActionDuration = .2;

-(id)init
{	
	self = [super init];
	if (self != nil)
	{
		[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"control-base.m4a"];

		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-1.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-2.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-3.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-4.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-5.caf"];

		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-1.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-2.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-3.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-4.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-5.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-6.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-7.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord1-8.caf"];
		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-1.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-2.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-3.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-4.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-5.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-6.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-7.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"control-chord2-8.caf"];
		
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"control-base.m4a"];
		
		button1Sprite = [CCSprite spriteWithFile:@"block.png"];
		button2Sprite = [CCSprite spriteWithFile:@"block.png"];
		button3Sprite = [CCSprite spriteWithFile:@"block.png"];
		button4Sprite = [CCSprite spriteWithFile:@"block.png"];
		
		button1 = [CCMenuItemSprite itemFromNormalSprite:button1Sprite selectedSprite:button1Sprite target:self selector:@selector(button1Tapped:)];
		button2 = [CCMenuItemSprite itemFromNormalSprite:button2Sprite selectedSprite:button2Sprite target:self selector:@selector(button2Tapped:)];
		button3 = [CCMenuItemSprite itemFromNormalSprite:button3Sprite selectedSprite:button3Sprite target:self selector:@selector(button3Tapped:)];
		button4 = [CCMenuItemSprite itemFromNormalSprite:button4Sprite selectedSprite:button4Sprite target:self selector:@selector(button4Tapped:)];
		
		button1.position = ccp(90, 310);
		button2.position = ccp(230, 310);
		button3.position = ccp(90, 170);
		button4.position = ccp(230, 170);
		
		button1Sprite.opacity = 192;
		button2Sprite.opacity = 192;
		button3Sprite.opacity = 192;
		button4Sprite.opacity = 192;

		CCMenu *starMenu = [CCMenu menuWithItems:button1, button2, button3, button4, nil];
		starMenu.position = CGPointZero;
		[self addChild:starMenu z:2];

		timer = 0;
		sequenceTimer = 0;
		beatPlaying = 1;
		sequencePosition = 1;
		buttonSequenceTimer = .5;
		songStarted = NO;
		chord2Wait = NO;
		songPosition = 0;
		
		[self schedule:@selector(mainLoop:)];
	}
	return self;
}

-(void)mainLoop:(ccTime)dt
{	
	timer = timer + dt;
	
	//make the buttons sway a bit
	button1.position = ccp(90+sin(timer*2)*3, 310+cos(3+timer*2)*3);
	button2.position = ccp(230+sin(1+timer*2)*3, 310+cos(2+timer*2)*3);
	button3.position = ccp(90+sin(2+timer*2)*3, 170+cos(1+timer*2)*3);
	button4.position = ccp(230+sin(3+timer*2)*3, 170+cos(timer*2)*3);

	sequenceTimer = sequenceTimer + dt;

	if(sequenceTimer >= 2)
	{
		sequenceTimer = 0;
		buttonSequenceTimer = .5; // keep timers in sync
		songStarted = YES;
		
		if(songPosition == 0)
		{
			[self playBeat:beatPlaying];
			[self playChord:2];			
		}
		else
		{
			[self playBeat:beatPlaying];
			[self playChord:1];
		}
		
	}
	
	buttonSequenceTimer = buttonSequenceTimer + dt;
	
	if(buttonSequenceTimer >= .5 && songStarted == YES)
	{
		buttonSequenceTimer = 0;

		if(sequencePosition == 1)
		{
			if(beatPlaying == 2)
				[button1 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:90]];

			if(beatPlaying == 3)
				[button1 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX*-1 scaleY:button1.scaleY]];

			if(beatPlaying == 4)
				[button1 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX scaleY:button1.scaleY*-1]];
			
			if(songPosition == 1)
				[button2 runAction:[CCScaleTo actionWithDuration:.2 scaleX:button2.scaleX*-1 scaleY:button2.scaleY*-1]];

			if(beatPlaying > 1 && beatPlaying < 5 && songPosition == 0) 
				[button3 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:-45]];

			sequencePosition++;
		} 
		else if(sequencePosition == 2)
		{
			if(beatPlaying == 2)
				[button2 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:90]];

			if(beatPlaying == 3)
				[button2 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX*-1 scaleY:button1.scaleY]];
				 
			if(beatPlaying == 4)
				[button2 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX scaleY:button2.scaleY*-1]];
			
			if(songPosition == 1)
				[button3 runAction:[CCScaleTo actionWithDuration:.2 scaleX:button3.scaleX*-1 scaleY:button3.scaleY*-1]];
			
			if(beatPlaying > 1 && beatPlaying < 5 && songPosition == 0) 
				[button4 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:-45]];

			sequencePosition++;
		}
		else if(sequencePosition == 3)
		{
			if(beatPlaying == 2)
				[button3 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:90]];
			
			if(beatPlaying == 3)
				[button3 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX*-1 scaleY:button1.scaleY]];
				 
			if(beatPlaying == 4)
				[button3 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX scaleY:button3.scaleY*-1]];
			
			if(songPosition == 1)
				[button4 runAction:[CCScaleTo actionWithDuration:.2 scaleX:button4.scaleX*-1 scaleY:button4.scaleY*-1]];
			
			if(beatPlaying > 1 && beatPlaying < 5 && songPosition == 0) 
				[button1 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:-45]];

			sequencePosition++;
		}
		else if(sequencePosition == 4)
		{
			if(beatPlaying == 2)
				[button4 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:90]];
			
			if(beatPlaying == 3)
				[button4 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX*-1 scaleY:button1.scaleY]];
				 
			if(beatPlaying == 4)
				[button4 runAction:[CCScaleTo actionWithDuration:kActionDuration scaleX:button1.scaleX scaleY:button4.scaleY*-1]];
			
			if(songPosition == 1)
				[button1 runAction:[CCScaleTo actionWithDuration:.2 scaleX:button1.scaleX*-1 scaleY:button1.scaleY*-1]];
			
			if(beatPlaying > 1 && beatPlaying < 5 && songPosition == 0) 
				[button2 runAction:[CCRotateBy actionWithDuration:kActionDuration angle:-45]];

			sequencePosition = 1;
		}
	}
}

-(void)button1Tapped:(id)sender
{
	songPosition = 0;

	button1Sprite.opacity = 255;
	[button1 runAction:[CCFadeTo actionWithDuration:.1 opacity:192]];
}

-(void)button2Tapped:(id)sender
{
	songPosition = 1;	

	button2Sprite.opacity = 255;
	[button2 runAction:[CCFadeTo actionWithDuration:.1 opacity:192]];
}

-(void)button3Tapped:(id)sender
{	
	beatPlaying--;
	if(beatPlaying < 1)
	{
		beatPlaying = 5;
	}

	button3Sprite.opacity = 255;
	[button3 runAction:[CCFadeTo actionWithDuration:.1 opacity:192]];
}

-(void)button4Tapped:(id)sender
{
	beatPlaying++;
	if(beatPlaying > 5)
	{
		beatPlaying = 1;
	}	

	button4Sprite.opacity = 255;
	[button4 runAction:[CCFadeTo actionWithDuration:.1 opacity:192]];
}

-(void)playChord:(int)chordType
{	
	int chord = (arc4random() % 8) + 1;

	if(chordType == 2)
	{
		if(chord2Wait == NO)
		{
			[[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"control-chord2-%d.caf", chord]];
			chord2Wait = YES;
		} 
		else
		{
			chord2Wait = NO;
		}
	}
	else
	{
		[[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"control-chord1-%d.caf", chord]];		
	}
}

-(void)playBeat:(int)beatType
{
	[[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"control-%d.caf", beatType]];
}

@end
