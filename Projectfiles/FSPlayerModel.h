//
//  FSPlayerModel.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSUserSkillModel.h"
@interface FSPlayerModel : NSObject
{
    FSUserSkillModel* skill;    // ユーザの持つスキルオブジェクト
    int hp;                     // 体力
    int mp;                     // 魔力
    int ms;                     // 魔法スロット
}
@property (readwrite) FSUserSkillModel* skill;
@property (readwrite) int hp;
@property (readwrite) int mp;
@property (readwrite) int ms;
@end
