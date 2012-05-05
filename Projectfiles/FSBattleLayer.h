//
//  FSBattleLayer.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "CCLayer.h"
#import "FSPlayerModel.h"
@interface FSBattleLayer : CCLayer
{
    FSPlayerModel* player;
    NSArray* magicCommand;
    int currentCommand;
    NSMutableArray* magicPointer;

}
extern int const MAGIC_AREA;
@property (readwrite) FSPlayerModel* player;
-(void) updatePlayerStatus;
-(void) changeTurn;
-(void) effectWater;
//-(CGPoint*) getMagicCommandArea;
@end