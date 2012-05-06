//
//  FSPlayerModel.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSUserSkillModel.h"
@interface FSPlayerModel : NSObject
{
    FSUserSkillModel* skill;
    int hp;
    int mp;
    int ms;
}
@property (readwrite) FSUserSkillModel* skill;
@property (readwrite) int hp;
@property (readwrite) int mp;
@property (readwrite) int ms;
@end
