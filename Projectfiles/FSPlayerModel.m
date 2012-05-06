//
//  FSPlayerModel.m
//  FastStory
//
//  自身の状態Model
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import "FSPlayerModel.h"
#import "FSUserSkillModel.h"
@implementation FSPlayerModel
@synthesize skill, hp, mp, ms;
-(id) init
{
    if ((self = [super init]))
    {
        FSUserSkillModel* modelObj = [[FSUserSkillModel alloc] init];
        self.skill = modelObj;
        
        // 仮ステータスとして主人公ステータスを定義
        hp = 100;
        mp = 200;
        ms = 3;
    }
    return self;
}
@end
