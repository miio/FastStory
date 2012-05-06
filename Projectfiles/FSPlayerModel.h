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
}
@property (readwrite) FSUserSkillModel* skill;
@end
