//
//  FSPlayerModel.m
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FSPlayerModel.h"
#import "FSUserSkillModel.h"
@implementation FSPlayerModel
@synthesize skill;
-(id) init
{
    if ((self = [super init]))
    {
        FSUserSkillModel* modelObj = [[FSUserSkillModel alloc] init];
        self.skill = modelObj;
    }
    return self;
}
@end
