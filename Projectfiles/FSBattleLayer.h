//
//  FSBattleLayer.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "CCLayer.h"
#import "FSPlayerModel.h"
#import "FSSkillModel.h"
@interface FSBattleLayer : CCLayer
{
    FSPlayerModel* player;
    FSSkillModel* magicCommand;
    int currentCommand;
    NSMutableArray* magicPointer;
    CCLabelTTF* skillTypeLabel;
    CCLabelTTF* skillNameLabel;
    CCLabelTTF* skillDetailLabel;
    CCLabelTTF* attackPointLabel;
    

}
extern int const MAGIC_AREA;
@property (readwrite) FSPlayerModel* player;
-(void) ready;
-(void) updatePlayerStatus;
-(void) updateSkillStatus;
-(void) changeTurn;
-(void) effectWater;
//-(CGPoint*) getMagicCommandArea;
@end