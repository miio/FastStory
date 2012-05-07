//
//  FSUserSkillModel.h
//  FastStory
//
//  Created by miio mitani on 12/05/06.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSUserSkillModel : NSObject
{
    NSMutableArray* hasSkill;   // プレーヤの持つスキルリスト
}
@property (readonly) NSMutableArray* hasSkill;
@end
