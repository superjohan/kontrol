//
//  ControlLayer.h
//  Control
//
//  Created by Johan Halin on 03.04.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface ControlLayer : CCLayer {

	CCMenuItem *button1;
	CCMenuItem *button2;
	CCMenuItem *button3;
	CCMenuItem *button4;
	
	CCSprite *button1Sprite;
	CCSprite *button2Sprite;
	CCSprite *button3Sprite;
	CCSprite *button4Sprite;
	
	float timer;
	float sequenceTimer;
	float buttonSequenceTimer;
	
	int beatPlaying;
	int sequencePosition;
	int songPosition;
	
	bool chord2Wait;
	bool songStarted;
	
	NSMutableArray *buttonEvents;
	
}

-(void)mainLoop:(ccTime)dt;

-(void)button1Tapped:(id)sender;
-(void)button2Tapped:(id)sender;
-(void)button3Tapped:(id)sender;
-(void)button4Tapped:(id)sender;

-(void)playChord:(int)chordType;
-(void)playBeat:(int)beatType;

@end
