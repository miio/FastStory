//
//  FSBattleLayer.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//
#import "CCLayer.h"
#import "FSPlayerModel.h"
#import "FSSkillModel.h"
#import "FSBattleUIMagicPointerLayer.h"
@interface FSBattleLayer : CCLayer
{
    FSPlayerModel* player;
    FSSkillModel* magicCommand;
    int currentCommand;
    NSMutableArray* magicPointer;
    FSBattleUIMagicPointerLayer* magicPointerLayer;
    
    // プレーヤステータスのラベル情報
    CCLabelTTF* hpLabel;
    CCLabelTTF* mpLabel;
    CCLabelTTF* msLabel;
    
    // スキルのラベル情報
    CCLabelTTF* skillTypeLabel;
    CCLabelTTF* skillNameLabel;
    CCLabelTTF* skillDetailLabel;
    CCLabelTTF* attackPointLabel;
    CCLabelTTF* useMpLabel;
    

}
extern int const MAGIC_AREA;
@property (readwrite) FSPlayerModel* player;
-(void) ready;
-(void) initPlayerStatus;
-(void) updatePlayerStatus;
-(void) initSkillStatus;
-(void) updateSkillStatus;
-(void) changeTurn;
-(void) effectWater;
//-(CGPoint*) getMagicCommandArea;
@end