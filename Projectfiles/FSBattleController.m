//
//  FSBattleController.m
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FSBattleController.h"
#import "FSBattleLayer.h"
#import "FSPlayerController.h"
#import "FSBattlePlayerController.h"
@implementation FSBattleController
-(id) init
{
	if ((self = [super init]))
	{
        FSBattleLayer* view = [[FSBattleLayer alloc] init];
        // 自プレーヤのコントローラを呼び出す
        FSBattlePlayerController* player = [[FSBattlePlayerController alloc] init];
        
        // 自身のパラメータをviewにセットする
        view.player = player.model;
        
        //FSPlayerController player = [[FSPlayerController alloc] init];
        
        
        [self addChild:view];
        [view ready];
    }
    return self;
}
@end
