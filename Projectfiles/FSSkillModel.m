//
//  FSSkillModel.m
//  FastStory
//
//  Created by miio mitani on 12/05/06.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import "FSSkillModel.h"

@implementation FSSkillModel
@synthesize skillType, skillLevel, attackPoint, skillName, skillDetail, magicPointer,useMp;

-(id) init
{
    if ((self = [super init]))
    {
        // 暫定的にモックデータで代用
        skillType = 0; // TODO: enumにする
        skillLevel = 1;
        attackPoint = 50;
        useMp = 50;
        skillName = @"ウォーターサークル";
        skillDetail = @"水の渦巻きによる攻撃！";
        magicPointer = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(300, 200)],
                                        [NSValue valueWithCGPoint:CGPointMake(500, 500)],
                                        [NSValue valueWithCGPoint:CGPointMake(650, 450)],
                                        [NSValue valueWithCGPoint:CGPointMake(250, 400)],
                                        nil];
    
    }
    return self;
}
@end
