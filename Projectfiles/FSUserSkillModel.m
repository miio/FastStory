//
//  FSUserSkillModel.m
//  FastStory
//
//  ユーザの持つスキルモデルクラス
//  Created by miio mitani on 12/05/06.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import "FSSkillModel.h"
#import "FSUserSkillModel.h"
@implementation FSUserSkillModel
@synthesize hasSkill;
//@
-(id) init
{
    if ((self = [super init]))
    {        
        // とりあえずモックアップとして適当に３種類くらいのスキルを作る
        FSSkillModel* skill0 = [[FSSkillModel alloc] init];
        FSSkillModel* skill1 = [[FSSkillModel alloc] init];
        skill1.skillType = 1;// 火
        skill1.skillLevel = 1;
        skill1.skillName = @"ファイアーサークル";
        skill1.skillDetail = @"火の渦巻きによる攻撃！";
        skill1.attackPoint = 50;
        skill1.useMp = 50;
        skill1.magicPointer = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(560, 340)],
                                       [NSValue valueWithCGPoint:CGPointMake(350, 250)],
                                       [NSValue valueWithCGPoint:CGPointMake(460, 450)],
                                       [NSValue valueWithCGPoint:CGPointMake(200, 300)],
                                       nil];
        
        FSSkillModel* skill2 = [[FSSkillModel alloc] init];
        skill2.skillType = 2;// 草
        skill2.skillLevel = 1;
        skill2.skillName = @"リーフサークル";
        skill2.skillDetail = @"草の渦巻きによる攻撃！";
        skill2.attackPoint = 50;
        skill2.useMp = 50;
        skill2.magicPointer = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(340, 560)],
                               [NSValue valueWithCGPoint:CGPointMake(200, 400)],
                               [NSValue valueWithCGPoint:CGPointMake(410, 320)],
                               [NSValue valueWithCGPoint:CGPointMake(250, 300)],
                               nil];
        
        // プレーヤの持つスキルとして追加する
        hasSkill = [[NSMutableArray alloc] initWithObjects:skill0,
                        skill1,
                        skill2,
                        nil];

    }
    return self;
}
@end
